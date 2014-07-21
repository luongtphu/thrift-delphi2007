/*
 Test simple type: Exception, enum, const
 */


namespace cpp sample2
namespace d sample2
namespace java sample2
namespace php sample2
namespace perl sample2

/**
 * define type same C style here.
 */
typedef i32 MyInteger

/**
 * Thrift also lets you define constants for use across languages. Complex
 * types and structs are specified using JSON notation.
 */
const i32 INT32CONSTANT = 9853
const map<string,string> MAPCONSTANT = {'hello':'world', 'goodnight':'moon'}

/**
 * You can define enums, which are just 32 bit integers. Values are optional
 * and start at 1 if not supplied, C style again.
 */
enum Operation {
  ADD = 1,
  SUBTRACT = 2,
  MULTIPLY = 3,
  DIVIDE = 4
}

/**
 * Structs are the basic complex data structures. They are comprised of fields
 * which each have an integer identifier, a type, a symbolic name, and an
 * optional default value.
 *
 * Fields can be declared "optional", which ensures they will not be included
 * in the serialized output if they aren't set.  Note that this requires some
 * manual management in some languages.
 */
struct Work {
  1: i32 num1 = 0,
  2: i32 num2,
  3: Operation op,
  4: optional string comment,
}

struct Xtruct
{
  1:  string string_thing,
  4:  byte   byte_thing,
  9:  i32    i32_thing,
  11: i64    i64_thing
}
/**
 * Structs can also be exceptions, if they are nasty.
 */
exception InvalidOperation {
  1: i32 what,
  2: string why
}

/**
 * Ahh, now onto the cool part, defining a service. Services just need a name
 * and can optionally inherit from another service using the extends keyword.
 */
service Sample2 {

 

	void ping(),

	i32 add(1:i32 num1, 2:i32 num2),

	i32 calculate(1:i32 logid, 2:Work w) throws (1:InvalidOperation ouch),

	void echoVoid(),
	byte echoByte(1: byte arg),
	i32 echoI32(1: i32 arg),
	i64 echoI64(1: i64 arg),
	string echoString(1: string arg),
	Xtruct echoXtruct(1: Xtruct arg),		
	list<byte>  echoList(1: list<byte> arg),
	set<byte>  echoSet(1: set<byte> arg),
	map<byte, byte>  echoMap(1: map<byte, byte> arg),   
	map<byte, Xtruct>  echoMapXtruct(1: map<byte, Xtruct> arg),   
 
	oneway void zip()

}

