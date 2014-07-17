(*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *)
 {
  Fix and modify Delphi version less 2010
  luongtphu@gmail.com
  Date:Nov 20 2013
 }
unit Thrift.Processor.Multiplex;


interface

uses
  SysUtils,
  uCollections,
  Thrift,
  Thrift.Protocol,
  Thrift.Protocol.Multiplex;

{ TMultiplexedProcessor is a TProcessor allowing a single TServer to provide multiple services.
  To do so, you instantiate the processor and then register additional processors with it,
  as shown in the following example:


     TMultiplexedProcessor processor = new TMultiplexedProcessor();

     processor.registerProcessor(
         "Calculator",
         new Calculator.Processor(new CalculatorHandler()));

     processor.registerProcessor(
         "WeatherReport",
         new WeatherReport.Processor(new WeatherReportHandler()));

     TServerTransport t = new TServerSocket(9090);
     TSimpleServer server = new TSimpleServer(processor, t);

     server.serve();
}


type
  IMultiplexedProcessor = interface( IProcessor)
    ['{AC9DE3F5-0F08-406B-86D8-A8D1DF1E30C1}']
    // Register a service with this TMultiplexedProcessor.  This allows us
    // to broker requests to individual services by using the service name
    // to select them at request time.
    procedure RegisterProcessor( const serviceName : String; const processor : IProcessor);
  end;


  TMultiplexedProcessorImpl = class( TInterfacedObject, IMultiplexedProcessor, IProcessor)
  private type
    // Our goal was to work with any protocol.  In order to do that, we needed
    // to allow them to call readMessageBegin() and get a TMessage in exactly
    // the standard format, without the service name prepended to TMessage.name.
    TStoredMessageProtocol = class( TProtocolDecorator)
    private
      FMessageBegin : IMessage;
    public
      constructor Create( const protocol : IProtocol; const aMsgBegin : IMessage);
      function ReadMessageBegin: IMessage; override;
    end;

  private
    FServiceProcessorMap : TuDictionary{TDictionary<String, IProcessor>};

    procedure Error( const oprot : IProtocol; const msg : IMessage;
                     extype : {TApplicationException.}TExceptionType; const etxt : string);

  public
    constructor Create;
    destructor Destroy;  override;

    // Register a service with this TMultiplexedProcessorImpl.  This allows us
    // to broker requests to individual services by using the service name
    // to select them at request time.
    procedure RegisterProcessor( const serviceName : String; const processor : IProcessor);

    { This implementation of process performs the following steps:
      - Read the beginning of the message.
      - Extract the service name from the message.
      - Using the service name to locate the appropriate processor.
      - Dispatch to the processor, with a decorated instance of TProtocol
        that allows readMessageBegin() to return the original TMessage.

      An exception is thrown if the message type is not CALL or ONEWAY
      or if the service is unknown (or not properly registered).
    }
    function Process(const iprot, oprot : IProtocol) : Boolean;
  end;


implementation

constructor TMultiplexedProcessorImpl.TStoredMessageProtocol.Create( const protocol : IProtocol; const aMsgBegin : IMessage);
begin
  inherited Create( protocol);
  FMessageBegin := aMsgBegin;
end;


function TMultiplexedProcessorImpl.TStoredMessageProtocol.ReadMessageBegin: IMessage;
begin
  result := FMessageBegin;
end;


constructor TMultiplexedProcessorImpl.Create;
begin
  inherited Create;
  FServiceProcessorMap :=TuDictionary.Create {TDictionary<string,IProcessor>.Create};
end;


destructor TMultiplexedProcessorImpl.Destroy;
begin
  try
    FreeAndNil( FServiceProcessorMap);
  finally
    inherited Destroy;
  end;
end;


procedure TMultiplexedProcessorImpl.RegisterProcessor( const serviceName : String; const processor : IProcessor);
begin
  FServiceProcessorMap.Add( _AllValue(serviceName), processor);
end;


procedure TMultiplexedProcessorImpl.Error( const oprot : IProtocol; const msg : IMessage;
                                           extype : {TApplicationException.}TExceptionType;
                                           const etxt : string);
var appex  : TApplicationException;
    newMsg : IMessage;
begin
  appex := TApplicationException.Create( extype, etxt);
  try
    newMsg := TMessageImpl.Create( msg.Name, {TMessageType.}Exception_, msg.SeqID);

    oprot.WriteMessageBegin(newMsg);
    appex.Write(oprot);
    oprot.WriteMessageEnd();
    oprot.Transport.Flush();

  finally
    appex.Free;
  end;
end;


function TMultiplexedProcessorImpl.Process(const iprot, oprot : IProtocol) : Boolean;
var msg, newMsg : IMessage;
    idx         : Integer;
    sService    : string;
    processor   : IProcessor;
    protocol    : IProtocol;
const
  ERROR_INVALID_MSGTYPE   = 'Message must be "call" or "oneway"';
  ERROR_INCOMPATIBLE_PROT = 'No service name found in "%s". Client is expected to use TMultiplexProtocol.';
  ERROR_UNKNOWN_SERVICE   = 'Service "%s" is not registered with MultiplexedProcessor';
var
  tintf:IInterface;
begin
  // Use the actual underlying protocol (e.g. TBinaryProtocol) to read the message header.
  // This pulls the message "off the wire", which we'll deal with at the end of this method.
  msg := iprot.readMessageBegin();
  if not (msg.Type_ in [{TMessageType.}Call, {TMessageType.}Oneway]) then begin
    Error( oprot, msg,
           {TApplicationException.TExceptionType.}InvalidMessageType,
           ERROR_INVALID_MSGTYPE);
    result:=false;
    Exit{( FALSE)};
  end;

  // Extract the service name
  idx := Pos( TMultiplexedProtocol.SEPARATOR, msg.Name);
  if idx < 1 then begin
    Error( oprot, msg,
           {TApplicationException.TExceptionType.}InvalidProtocol,
           Format(ERROR_INCOMPATIBLE_PROT,[msg.Name]));
    result:=false;
    Exit{( FALSE)};
  end;

  // Create a new TMessage, something that can be consumed by any TProtocol
  sService := Copy( msg.Name, 1, idx-1);
  if not FServiceProcessorMap.TryGetValueIntf( sService, tintf{processor})
  then begin
    Error( oprot, msg,
           {TApplicationException.TExceptionType.}InternalError,
           Format(ERROR_UNKNOWN_SERVICE,[sService]));
    result:=false;
    Exit{( FALSE)};
  end;

  processor:=IProcessor(tintf);
  // Create a new TMessage, removing the service name
  Inc( idx, Length(TMultiplexedProtocol.SEPARATOR));
  newMsg := TMessageImpl.Create( Copy( msg.Name, idx, MAXINT), msg.Type_, msg.SeqID);

  // Dispatch processing to the stored processor
  protocol := TStoredMessageProtocol.Create( iprot, newMsg);
  result   := processor.process( protocol, oprot);
end;


end.

