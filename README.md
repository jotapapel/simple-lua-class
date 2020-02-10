# Simple LUA Class system for TIC80
A tiny and simple LUA class system developed for the TIC80 platform.

## Example
```Lua
local Dog = class{sound = "bark!"}
function Dog:constructor(name)
	self.name = name
end
Dog:implement({
	speak = function(self)
		print(self.sound)
	end
})

local puppy = Dog:new("Max")

print(puppy) --> "object: 0x60000273cb40"
print(puppy.name) --> "Max"
puppy:speak() --> "bark!"
```

## Documentation
### Creating a new class
``local Class = class{var = value[, var2 = value2]}``
```Lua
local Horse = class{}
local Dog = class{sound = "bark!"}

print(Horse) --> "class: 0x600002739000"
print(Dog) --> "class: 0x60000273cb40"
```
### Extending an existing class
``local Class2 = Class:extend{var = value[, var2 = value2]}``
```Lua
local Dog = class{sound = "bark!"}
local Labrador = Dog:extend{toy = "ball"}

local puppy = Labrador:new()

print(Dog) --> "class: 0x60000273cb40"
print(puppy.class.super) --> "class: 0x60000273cb40"
print(puppy.sound) --> "bark!"
print(puppy.toy) --> "ball"
```

Note: The varible *class.super*  is protected so it cannot be (easily) modified by the user
```Lua
puppy.class.super = "something"
print(puppy.class.super) --> "class: 0x60000273cb40"
```
### Adding variables to the class
#### Static variables
``Class:implement({var = value[, var2 = value2]}, true)``


Static variables are added to the class and are not passed directly to objects created from that class, they are instead accessed by calling the objects *class* variable first.
```Lua
local Dog = class{sound = "bark!"}
Dog:implement({breed = "Labrador"}, true)
local puppy = Dog:new()

print(puppy.breed) --> "nil"
print(puppy.class.breed) --> "Labrador"
```
#### Non-static variables
``Class:implement({var = value[, var2 = value2]}[, false])``


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
>``local obj = Class:new([var, var2])``
```Lua
-- default
local Dog = class{sound = "bark!"}
local puppy = Dog:new()

print(puppy) --> "object: 0x60000273cb40"
print(puppy.sound) --> "bark!"

-- custom constructor
local Cat = class{sound = "meow!"}
function Cat:constructor(name)
	self.name = name
end

local kitten = Cat:new("Leo")

print(kitten) --> "object: 0x60000273cb40"
print(kitten.sound) --> "meow!"
print(kitten.name) --> "Leo"
```

When an object is created the system also asigns it with a unique id which can be created by the user.
```Lua
-- default
local Dog = class{sound = "bark!"}
local puppy = Dog:new()

print(puppy.id) --> "0x60000273cb40"

-- custom id
local catCount = 0
local Cat = class{sound = "meow!"}
function Cat:id()
	catCount = catCount + 1
	return 'K'..tostring(catCount)
end

local kitten = Cat:new()
print(kitten.id) --> "K1"

local kitten = Cat:new()
print(kitten.id) --> "K2"
```

Note: The varibles *object.class* and *object.id*  are protected so they cannot be (easily) modified by the user
```Lua
puppy.class = class{}
puppy.id = 90

print(puppy.class) --> "class: 0x60000273cb40"
print(puppy.id) --> "0x60000273cb40"
```
