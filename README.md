# Simple LUA Class system for TIC80
A tiny and simple LUA class system developed for the TIC80 platform.

## Example
```Lua
local Dog = class{sound = "bark!"}
function Dog:constructor(name)
	self.name = name
end

local puppy = Dog:new("Max")

print(puppy) --> "object: 0x60000273cb40"
print(puppy.name) --> "Max"
print(puppy.sound) --> "bark!"
```

## Documentation
### Creating a new class
```Lua
local Horse = class{}
local Dog = class{sound = "bark!"}

print(Horse) --> "class: 0x600002739000"
print(Dog) --> "class: 0x60000273cb40"
```
### Extending an existing class
```Lua
local Dog = class{sound = "bark!"}
local Labrador = Dog:extend{toy = "ball"}

local puppy = Labrador:new()

print(Dog) --> "class: 0x60000273cb40"
print(puppy.class.super) --> "class: 0x60000273cb40"
print(puppy.sound) --> "bark!"
print(puppy.toy) --> "ball"

puppy.class.super = "something"
print(puppy.class.super) --> "class: 0x60000273cb40"
```
Note: The varible *class.super*  is protected so it cannot be (easily) modified by the user
### Adding variables to the class
#### Static variables
Static variables are added to the class and are not passed directly onto the objects created from that class, they are instead accessed by calling the objects class first.
```Lua
local Dog = class{sound = "bark!"}
Dog:implement({breed = "Labrador"}, true)
local puppy = Dog:new()

print(puppy.breed) --> "nil"
print(puppy.class.breed) --> "Labrador"
```
#### Non-static variables
Non-static variables are added directly to the objects.
```Lua
local Dog = class{sound = "bark!"}
Dog:implement({color = "brown"})
local puppy1 = Dog:new()
local puppy2 = Dog:new()

puppy2.color = "golden"

print(puppy1.color) --> "brown"
print(puppy2.color) --> "golden"
```
### Creating a new object
```Lua
local Dog = class{sound = "bark!"}
local puppy = Dog:new()

print(puppy) --> "object: 0x60000273cb40"
print(puppy.sound) --> "bark!"

local Cat = class{sound = "meow!"}
function Cat:constructor(name)
	self.name = name
end

local kitten = Cat:new("Leo")

print(kitten) --> "object: 0x60000273cb40"
print(kitten.sound) --> "meow!"
print(kitten.name) --> "Leo"
```
When an object is created the system can also asign it with a unique id.
```Lua
-- generic id
local Dog = class{sound = "bark!"}
local puppy = Dog:new()

print(puppy.id) --> "0x60000273cb40"

-- custom id
local catCount = 0
local Cat = class{sound = "meow!"}
function Cat:id(object)
	catCount = catCount + 1
	return 'K'..tostring(catCount)
end

local kitten = Cat:new()

print(kitten.id) --> "K1"
```
Note: The varibles *object.id* and *object.class*  are protected so they cannot be (easily) modified by the user
```Lua
local Dog = class{sound = "bark!"}
local puppy = Dog:new()

print(puppy.id) --> "0x60000273cb40"
puppy.id = 8
print(puppy.id) --> "0x60000273cb40"
```
