---@meta

--luacheck:ignore
---@class fun
local m = {}

m.op = {
    ---Returns a < b
    lt = function(a, b) end,
    ---Return a <= b
    le = function(a, b) end,
    ---Return a == b
    eq = function(a, b) end,
    ---Return a ~= b
    ne = function(a, b) end,
    ---Return a a >= b
    ge = function(a, b) end,
    ---Return a a > b
    gt = function(a, b) end,
    ---Return a + b
    add = function(a, b) end,
    ---Return a / b
    div = function(a, b) end,
    ---Returns math.floor(a / b)
    floordiv = function(a, b) end,
    ---Return C-like integer division.
    intdiv = function(a, b) end,
    ---Return a % b
    mod = function(a, b) end,
    ---Return a * b
    mul = function(a, b) end,
    ---Return -a
    neq = function(a) end,
    ---Return -a
    unm = function(a) end,
    ---Return a ^ b
    pow = function(a, b) end,
    ---Return a - b
    sub = function(a, b) end,
    ---Return a / b
    truediv = function(a, b) end,
    ---Return a .. b
    concat = function(a, b) end,
    ---Return #a
    len = function(a) end,
    ---Return #a
    length = function(a) end,
    ---Return a and b
    land = function(a, b) end,
    ---Return a or b
    lor = function(a, b) end,
    ---Return not a
    lnot = function(a) end,
    ---Return not not a
    truth = function(a) end,
}

---@alias IteratorGen fun(param: any, state: any):(state: any, ...: any)

---@class Iterator
---@overload fun(param: any, state: any):(state: any, ...: any)
local i = {}

---Returns number of elements
---@param arg Iterator|table|string
---@return integer # length of the items
function m.length(arg) end

---@param arg Iterator|table|string
---@return any[]
function m.totable(arg) end

---@param arg Iterator|table
---@return table<any, any>
function m.tomap(arg) end

---Make ``gen, param, state`` iterator from the iterable object.
---The function is a generalized version of :func:`pairs` and :func:`ipairs`.
---
---The function distinguish between arrays and maps using ``#arg == 0``
---check to detect maps. For arrays ``ipairs`` is used. For maps a modified
---version of ``pairs`` is used that also returns keys. Userdata objects
---are handled in the same way as tables.
---
---All library iterator are suitable to use with Lua's ``for .. in`` loop.
---@param arg Iterator|table|string
---@return Iterator gen, any param, any state
---@overload fun(gen: IteratorGen, param, state: any):(gen: Iterator, param: any, state: any)
function m.iter(arg) end

---@param gen IteratorGen
---@param param any
---@param state any
---@return Iterator gen, any param, any state
function m.wrap(gen, param, state) end

---Checks that all items accepts given condition

---Returns true if all return values of iterator satisfy the `predicate`.
---@param arg Iterator|table|string
---@param predicate fun(...):boolean acceptor
---@return boolean
---@overload fun(predicate: (fun(...):boolean), gen: IteratorGen, param, state: any):boolean
function m.all(predicate, arg) end

---Returns true if all return values of iterator satisfy the `predicate`.
---@param arg Iterator|table|string
---@param predicate fun(...):boolean acceptor
---@return boolean
---@overload fun(predicate: (fun(...):boolean), gen: IteratorGen, param, state: any):boolean
function m.every(predicate, arg) end

---Returns the `n`-th element of `arg`. If the iterator does not have n items then nil is returned
---@param n integer a sequential number (indexed starting from 1, like Lua tables)
---@param arg Iterator|table|string
---@return any ...
---@overload fun(n: integer, gen: IteratorGen, param, state: any):(...: any)
function m.nth(n, arg) end

---Extract the first element of `arg`. If the iterator is empty then an error is raised.
---@param arg Iterator|table|string
---@return any
---@overload fun(gen: IteratorGen, param, state: any):any
function m.head(arg) end

---Extract the first element of `arg`. If the iterator is empty then an error is raised.
---@param arg Iterator|table|string
---@return any
---@overload fun(gen: IteratorGen, param, state: any):any
function m.car(arg) end

---Return a copy of iterator without its first element.
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(gen: IteratorGen, param, state: any):Iterator
function m.tail(arg) end

---Return a copy of iterator without its first element.
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(gen: IteratorGen, param, state: any):Iterator
function m.cdr(arg) end

---Ends iterator when predicate returns falsy.
---@param predicate fun(...): boolean
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(predicate: (fun(...):boolean), gen: IteratorGen, param, state: any):Iterator
function m.take_while(predicate, arg) end

---Ends iterator after n iterations
---@param n integer a number of elements to take
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(n: integer, gen: IteratorGen, param, state: any):Iterator
function m.take_n(n, arg) end

---An alias for `take_n()`
---@param n integer
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(n: integer, gen: IteratorGen, param, state: any):Iterator
function m.take(n, arg) end

---An alias for `take_while()`
---@param predicate fun(...): boolean
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(predicate: (fun(...):boolean), gen: IteratorGen, param, state: any):Iterator
function m.take(predicate, arg) end

---Skips items while predicate is false
---@param predicate fun(...): boolean
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(predicate: (fun(...):boolean), gen: IteratorGen, param, state: any):Iterator
function m.drop_while(predicate, arg) end

---Skips first n iterations
---@param n integer a number of elements to drop
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(n: integer, gen: IteratorGen, param, state: any):Iterator
function m.drop_n(n, arg) end

---An alias for `drop_n()`
---@param n integer
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(n: integer, gen: IteratorGen, param, state: any):Iterator
function m.drop(n, arg) end

---An alias for `drop_while()`
---@param predicate fun(...): boolean
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(predicate: (fun(...):boolean), gen: IteratorGen, param, state: any):Iterator
function m.drop(predicate, arg) end

---Return an iterator pair
---where the first operates on the longest prefix (possibly empty) of gen, param, state iterator of elements
---that satisfy predicate and second operates the remainder of gen, param, state iterator.
---@param n integer
---@param arg Iterator|table|string
---@return Iterator, Iterator
---@overload fun(n: integer, gen: IteratorGen, param, state: any):Iterator, Iterator
function m.span(n, arg) end

---Return an iterator pair
---where the first operates on the longest prefix (possibly empty) of gen, param, state iterator of elements
---that satisfy predicate and second operates the remainder of gen, param, state iterator.
---@param predicate fun(...): boolean
---@param arg Iterator|table|string
---@return Iterator, Iterator
---@overload fun(predicate: (fun(...):boolean), gen: IteratorGen, param, state: any):Iterator, Iterator
function m.span(predicate, arg) end

---Return an iterator pair
---where the first operates on the longest prefix (possibly empty) of gen, param, state iterator of elements
---that satisfy predicate and second operates the remainder of gen, param, state iterator.
---@param n integer
---@param arg Iterator|table|string
---@return Iterator, Iterator
---@overload fun(n: integer, gen: IteratorGen, param, state: any):Iterator, Iterator
function m.split(n, arg) end

---Return an iterator pair
---where the first operates on the longest prefix (possibly empty) of gen, param, state iterator of elements
---that satisfy predicate and second operates the remainder of gen, param, state iterator.
---@param predicate fun(...): boolean
---@param arg Iterator|table|string
---@return Iterator, Iterator
---@overload fun(predicate: (fun(...):boolean), gen: IteratorGen, param, state: any):Iterator, Iterator
function m.split(predicate, arg) end

---Return an iterator pair
---where the first operates on the longest prefix (possibly empty) of gen, param, state iterator of elements
---that satisfy predicate and second operates the remainder of gen, param, state iterator.
---@param n integer
---@param arg Iterator|table|string
---@return Iterator, Iterator
---@overload fun(n: integer, gen: IteratorGen, param, state: any):Iterator, Iterator
function m.split_at(n, arg) end

---Return an iterator pair
---where the first operates on the longest prefix (possibly empty) of gen, param, state iterator of elements
---that satisfy predicate and second operates the remainder of gen, param, state iterator.
---@param predicate fun(...): boolean
---@param arg Iterator|table|string
---@return Iterator, Iterator
---@overload fun(predicate: (fun(...):boolean), gen: IteratorGen, param, state: any):Iterator, Iterator
function m.split_at(predicate, arg) end

---The iterator to create arithmetic progressions.
---Iteration values are generated within closed interval ``[start, stop]`` (i.e. *stop* is included).
---If the *start* argument is omitted, it defaults to ``1`` (*stop* > 0) or ``-1`` (*stop* < 0).
---If the *step* argument is omitted, it defaults to ``1`` (*start* <= *stop*) or to ``-1`` (*start* > *stop*).
---If *step* is positive, the last element is the largest ``start + i * step`` less than or equal to *stop*;
---if *step* is negative, the last element is the smallest ``start + i * step`` greater than or equal to *stop*.
---*step* must not be zero (or else an error is raised). ``range(0)`` returns empty iterator.
---@overload fun(stop: number): Iterator
---@overload fun(start: number, stop: number): Iterator
---@overload fun(start: number, stop: number, step: number): Iterator
function m.range(start, stop, step) end

---The iterator returns values over and over again indefinitely.
---All values that passed to the iterator are returned as-is during the iteration.
---@return Iterator
function m.duplicate(...) end

---An alias for `duplicate`
---@return Iterator
function m.xrepeat(...) end

---An alias for `duplicate`
---@return Iterator
function m.replicate(...) end

---The iterator that returns ``fun(0)``, ``fun(1)``, ``fun(2)``, ``...`` values indefinitely.
---@param func fun(n: integer):...
---@return Iterator
function m.tabulate(func) end

---The iterator returns 0 indefinitely.
---@return Iterator<number>
function m.zeros() end

---Remaps content of arg
---@param mapper fun(...):...
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(mapper: fun(...):(...: any), gen: IteratorGen, param, state: any):Iterator
function m.map(mapper, arg) end

---Returns `true` if the first `iterator1` is a prefix of the `iterator2`.
---@param iterator1 Iterator|table|string
---@param iterator2 Iterator|table|string
---@return boolean
function m.is_prefix_of(iterator1, iterator2) end

---Returns `true` when iterator is empty or finished, false otherwise.
---@param arg Iterator|table|string
---@return boolean
---@overload fun(gen: IteratorGen, param, state: any): boolean
function m.is_null(arg) end

---Returns iterator by enumerating all elements starting from 1.
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(gen: IteratorGen, param, state: any): Iterator
function m.enumerate(arg) end

---Return a new iterator where the `x` value is interspersed between the elements of the source iterator.
---@param arg Iterator|table|string
---@param x any
---@return Iterator
---@overload fun(x: any, gen: IteratorGen, param, state: any): Iterator
function m.intersperse(x, arg) end

---Filters given arguments with given regexp
---@param regexp string
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(regexp: string, gen: IteratorGen, param, state: any): Iterator
function m.grep(regexp, arg) end

---Filters given arguments with given predicate
---@param predicate fun(...): boolean
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(predicate: (fun(...): boolean), gen: IteratorGen, param, state: any): Iterator
function m.grep(predicate, arg) end

---Filters given arguments with given predicate
---@param predicate fun(...): boolean
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(predicate: (fun(...): boolean), gen: IteratorGen, param, state: any): Iterator
function m.filter(predicate, arg) end

---Filters given arguments with given predicate
---@param predicate fun(...): boolean
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(predicate: (fun(...): boolean), gen: IteratorGen, param, state: any): Iterator
function m.remove_if(predicate, arg) end

---Returns two iterators where elements do and do not satisfy the prediucate.
---@param arg Iterator|table|string
---@param predicate fun(...): boolean
---@return Iterator, Iterator
---@overload fun(predicate: (fun(...): boolean), gen: IteratorGen, param, state: any):Iterator,Iterator
function m.partition(predicate, arg) end

---Zips N iterators into one
---@param ... Iterator|table|string
---@return Iterator
function m.zip(...) end

---Return cycled infinity iterator
---@param arg Iterator|table|string
---@return Iterator
---@overload fun(gen: IteratorGen, param, state: any): Iterator
function m.cycle(arg) end

---Chains given iterators to single iterator
---@param ... Iterator|table|string
---@return Iterator
function m.chain(...) end

---The iterator that returns ``1`` indefinitely.
---@return Iterator
function m.ones() end

---The iterator returns random values using `math.random()`.
---If the `n` and `m` are set then the iterator returns pseudo-random integers in the `[n, m)` interval (i.e. *m* is not included).
---If the m is not set then the iterator generates pseudo-random integers in the [0, n) interval.
---When called without arguments returns pseudo-random real numbers with uniform distribution in the interval [0, 1).
---@param n? integer an endpoint of the interval
---@param m? integer an endpoint of the interval
---@return Iterator
function m.rands(n, m) end

---Calls func for each value
---@param func fun(...)
---@param arg Iterator|table|string
---@overload fun(func: (fun(...): boolean), gen: IteratorGen, param, state: any): Iterator
function m.each(func, arg) end

---Calls func for each value
---@param func fun(...)
---@param arg Iterator|table|string
---@overload fun(func: (fun(...): boolean), gen: IteratorGen, param, state: any): Iterator
function m.foreach(func, arg) end

---Calls func for each value
---@param func fun(...)
---@param arg Iterator|table|string
---@overload fun(func: (fun(...): boolean), gen: IteratorGen, param, state: any): Iterator
function m.for_each(func, arg) end

---The function returns the position of the first element in the given iterator
---which is equal (using ==) to the query element, or nil if there is no such element.
---@param x any a value to find
---@param arg Iterator|table|string
---@return integer # the position of the first element that equals to the x
---@overload fun(x: any, gen: IteratorGen, param, state: any): Iterator
function m.index(x, arg) end

---The function returns the position of the first element in the given iterator
---which is equal (using ==) to the query element, or nil if there is no such element.
---@param x any a value to find
---@param arg Iterator|table|string
---@return integer # the position of the first element that equals to the x
---@overload fun(x: any, gen: IteratorGen, param, state: any): Iterator
function m.index_of(x, arg) end

---The function returns the position of the first element in the given iterator
---which is equal (using ==) to the query element, or nil if there is no such element.
---@param x any a value to find
---@param arg Iterator|table|string
---@return integer # the position of the first element that equals to the x
---@overload fun(x: any, gen: IteratorGen, param, state: any): Iterator
function m.elem_index(x, arg) end

---The function returns an iterator to positions of elements which equals to the query element.
---@param x any a value to find
---@param arg Iterator|table|string
---@return Iterator # an iterator which positions of elements that equal to the x
---@overload fun(x: any, gen: IteratorGen, param, state: any): Iterator
function m.indexes(x, arg) end

---The function returns an iterator to positions of elements which equals to the query element.
---@param x any a value to find
---@param arg Iterator|table|string
---@return Iterator # an iterator which positions of elements that equal to the x
---@overload fun(x: any, gen: IteratorGen, param, state: any): Iterator
function m.indices(x, arg) end

---The function returns an iterator to positions of elements which equals to the query element.
---@param x any a value to find
---@param arg Iterator|table|string
---@return Iterator # an iterator which positions of elements that equal to the x
---@overload fun(x: any, gen: IteratorGen, param, state: any): Iterator
function m.elem_indexes(x, arg) end

---The function returns an iterator to positions of elements which equals to the query element.
---@param x any a value to find
---@param arg Iterator|table|string
---@return Iterator # an iterator which positions of elements that equal to the x
---@overload fun(x: any, gen: IteratorGen, param, state: any): Iterator
function m.elem_indices(x, arg) end

---Sum up all iteration values.
---@param arg Iterator|table|string
---@return number
---@overload fun(gen: IteratorGen, param, state: any): number
function m.sum(arg) end

---Multiply all iteration values.
---@param arg Iterator|table|string
---@return number
---@overload fun(gen: IteratorGen, param, state: any): number
function m.product(arg) end

---Return a minimum value from the iterator.
---@param arg Iterator|table|string
---@return any
---@overload fun(gen: IteratorGen, param, state: any): any
function m.min(arg) end

---Return a minimum value from the iterator.
---@param arg Iterator|table|string
---@return any
---@overload fun(gen: IteratorGen, param, state: any): any
function m.minimum(arg) end

---Return a minimum value from the iterator using the `cmp`.
---@param cmp fun(a, b: any):boolean
---@param arg Iterator|table|string
---@return any
---@overload fun(cmp: (fun(a, b: any):boolean), gen: IteratorGen, param, state: any): any
function m.min_by(cmp, arg) end

---Return a minimum value from the iterator using the `cmp`.
---@param cmp fun(a, b: any):boolean
---@param arg Iterator|table|string
---@return any
---@overload fun(cmp: (fun(a, b: any):boolean), gen: IteratorGen, param, state: any): any
function m.minimum_by(cmp, arg) end

---Return a maximum value from the iterator.
---@param arg Iterator|table|string
---@return any
---@overload fun(gen: IteratorGen, param, state: any): any
function m.max(arg) end

---@param arg Iterator|table|string
---@return any
---@overload fun(gen: IteratorGen, param, state: any): any
function m.maximum(arg) end

---@param cmp fun(a, b: any):boolean
---@param arg Iterator|table|string
---@return any
---@overload fun(cmp: (fun(a, b: any):boolean), gen: IteratorGen, param, state: any): any
function m.max_by(cmp, arg) end

---The function reduces the iterator from left to right
---using the binary operator `accfun` and the initial value `initval`.
---@param accfun fun(acc: any, ...:any):any an accumulating function
---@param init_val any? an initial value that passed to `accfun` on the first iteration
---@param arg Iterator|table|string
---@return any
---@overload fun(accfun: (fun(acc: any, ...:any):any), init_val: any?, gen: IteratorGen, param, state: any): any
function m.foldl(accfun, init_val, arg) end

---The function reduces the iterator from left to right
---using the binary operator `accfun` and the initial value `initval`.
---@param accfun fun(acc: any, ...:any):any an accumulating function
---@param init_val any? an initial value that passed to `accfun` on the first iteration
---@param arg Iterator|table|string
---@return any
---@overload fun(accfun: (fun(acc: any, ...:any):any), init_val: any?, gen: IteratorGen, param, state: any): any
function m.reduce(accfun, init_val, arg) end

---Remaps content of iterator
---@param mapper fun(...):...
---@return Iterator
function i:map(mapper) end

---Returns iterator by enumerating all elements starting from 1.
---@return Iterator
function i:enumerate() end

---Return a new iterator where the `x` value is interspersed between the elements of the source iterator.
---@return Iterator
function i:intersperse(x) end

---Filters original iterator with given regexp
---@param regexp string regular expression to build filtering predicate.
---@return Iterator
function i:grep(regexp) end

---Filters original iterator with given predicate
---@param predicate fun(...): boolean an predicate to filter the iterator
---@return Iterator
function i:grep(predicate) end

---Filters original iterator with given predicate
---@param predicate fun(...): boolean an predicate to filter the iterator
---@return Iterator
function i:filter(predicate) end

---Filters original iterator with given predicate
---@param predicate fun(...): boolean an predicate to filter the iterator
---@return Iterator
function i:remove_if(predicate) end

---Returns two iterators where elements do and do not satisfy the prediucate.
---@param predicate fun(...): boolean
---@return Iterator, Iterator
function i:partition(predicate) end

---Counts length of iterator (reducer)
---@return integer
function i:length() end

---Builds list of iterator (reducer)
---@return any[]
function i:totable() end

---Builds kv map of the iterator (reducer)
---@return table<any, any>
function i:tomap() end

---Returns `true` if the self iterator is a prefix of the `arg`.
---@param arg Iterator|table|string
---@return boolean
function i:is_prefix_of(arg) end

---Returns `true` when iterator is empty or finished, false otherwise.
---@return boolean
function i:is_null() end

---Returns `true` if all return values of iterator satisfy the `predicate`.
---@param predicate fun(...):boolean acceptor
---@return boolean
function i:all(predicate, arg) end

---Returns `true` if all return values of iterator satisfy the `predicate`.
---@param predicate fun(...):boolean acceptor
---@return boolean
function i:every(predicate, arg) end

---Zips iterators into one
---@param ... Iterator|table|string
---@return Iterator
function i:zip(...) end

---Return cycled infinity iterator
---@return Iterator
function i:cycle(arg) end

---Chains given iterator to single iterator
---@param ... Iterator|table|string
---@return Iterator
function i:chain(...) end

---Sum up all iteration values.
---@return number
function i:sum() end

---Multiply all iteration values.
---@return number
function i:product(arg) end

---Return a minimum value from the iterator.
---@return any
function i:min() end

---Return a minimum value from the iterator.
---@return any
function i:minimum() end

---Return a minimum value from the iterator using the `cmp`
---@param cmp fun(a, b: any): boolean
---@return any
function i:min_by(cmp) end

---Return a minimum value from the iterator using the `cmp`
---@param cmp fun(a, b: any): boolean
---@return any
function i:minimum_by(cmp) end

---Return a maximum value from the iterator.
---@return any
function i:max() end

---Return a maximum value from the iterator.
---@return any
function i:maximum() end

---Return a maximum value from the iterator using the `cmp`.
---@param cmp fun(a, b: any): boolean
---@return any
function i:max_by(cmp) end

---Returns the `n`-th element of iterator. If the iterator does not have n items then nil is returned.
---@param n integer a sequential number (indexed starting from 1, like Lua tables)
---@return any ...
function i:nth(n) end

---Extract the first element of iterator. If the iterator is empty then an error is raised.
---@return any
function i:head() end

---Extract the first element of iterator. If the iterator is empty then an error is raised.
---@return any
function i:car() end

---Return a copy of iterator without its first element.
---@return Iterator
function i:tail() end

---Return a copy of iterator without its first element.
---@return Iterator
function i:cdr() end

---Ends iterator when predicate returns falsy.
---@param predicate fun(...): boolean
---@return Iterator
function i:take_while(predicate) end

---Ends iterator after n iterations
---@param n integer a number of elements to take
---@return Iterator
function i:take_n(n) end

---An alias for `take_n()`
---@param n integer
---@return Iterator
function i:take(n) end

---An alias for `take_while()`
---@param predicate fun(...): boolean
---@return Iterator
function i:take(predicate) end

---Skips items while predicate is false
---@param predicate fun(...): boolean
---@return Iterator
function i:drop_while(predicate) end

---Skips first n iterations
---@param n integer a number of elements to drop
---@return Iterator
function i:drop_n(n) end

---An alias for `drop_n()`
---@param n integer
---@return Iterator
function i:drop(n) end

---An alias for `drop_while()`
---@param predicate fun(...): boolean
---@return Iterator
function i:drop(predicate) end

---Return an iterator pair
---where the first operates on the longest prefix (possibly empty) of gen, param, state iterator of elements
---that satisfy predicate and second operates the remainder of gen, param, state iterator.
---@param n integer
---@return Iterator, Iterator
function i:span(n) end

---Return an iterator pair
---where the first operates on the longest prefix (possibly empty) of gen, param, state iterator of elements
---that satisfy predicate and second operates the remainder of gen, param, state iterator.
---@param predicate fun(...): boolean
---@return Iterator, Iterator
function i:span(predicate) end

---An alias for `span()`.
---@param n integer
---@return Iterator, Iterator
function i:split(n) end

---An alias for `span()`.
---@param predicate fun(...): boolean
---@return Iterator, Iterator
function i:split(predicate) end

---An alias for `span()`.
---@param n integer
---@return Iterator, Iterator
function i:split_at(n) end

---An alias for span().
---@param predicate fun(...): boolean
---@return Iterator, Iterator
function i:split_at(predicate) end

---Calls func for each value
---@param func fun(...):...
function i:each(func) end

---Calls func for each value
---@param func fun(...):...
function i:foreach(func) end

---Calls func for each value
---@param func fun(...):...
function i:for_each(func) end

---The function returns the position of the first element in the given iterator
---which is equal (using ==) to the query element, or nil if there is no such element.
---@param x any a value to find
---@return integer # the position of the first element that equals to the x
function i:index(x) end

---The function returns the position of the first element in the given iterator
---which is equal (using ==) to the query element, or nil if there is no such element.
---@param x any a value to find
---@return integer # the position of the first element that equals to the x
function i:index_of(x) end

---The function returns the position of the first element in the given iterator
---which is equal (using ==) to the query element, or nil if there is no such element.
---@param x any a value to find
---@return integer # the position of the first element that equals to the x
function i:elem_index(x) end

---The function returns an iterator to positions of elements which equals to the query element.
---@param x any a value to find
---@return Iterator # an iterator which positions of elements that equal to the x
function i:indexes(x) end

---The function returns an iterator to positions of elements which equals to the query element.
---@param x any a value to find
---@return Iterator # an iterator which positions of elements that equal to the x
function i:indices(x) end

---The function returns an iterator to positions of elements which equals to the query element.
---@param x any a value to find
---@return Iterator # an iterator which positions of elements that equal to the x
function i:elem_indexes(x) end

---The function returns an iterator to positions of elements which equals to the query element.
---@param x any a value to find
---@return Iterator # an iterator which positions of elements that equal to the x
function i:elem_indices(x) end

---The function reduces the iterator from left to right
---using the binary operator `accfun` and the initial value `initval`.
---@param accfun fun(acc: any, ...:any):any an accumulating function
---@param init_val any? an initial value that passed to `accfun` on the first iteration
---@return any
function i:reduce(accfun, init_val) end

---The function reduces the iterator from left to right
---using the binary operator `accfun` and the initial value `initval`.
---@param accfun fun(acc: any, ...:any):any an accumulating function
---@param init_val any? an initial value that passed to `accfun` on the first iteration
---@return any
function i:foldl(accfun, init_val) end

---Returns native iterator triplet
---@return IteratorGen gen, any param, any state
function i:unwrap() end

return m
