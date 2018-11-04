val fragments = ["h","he","li","be","b","c","n","o","f","ne","na","mg"];


structure StringKey =
struct
    type ord_key = string
    val compare = String.compare
end;


structure SMap = RedBlackMapFn(StringKey);
structure SSet = RedBlackSetFn(StringKey);




fun organize ([], m) = m | organize (x::xs, m) = organize(xs,
	let
		val c = Char.toString(String.sub(x, 0))
	in
		if SMap.inDomain(m, c)
		then SMap.insert(m, c, SSet.add(valOf(SMap.find(m, c)),x))
		else SMap.insert(m, c, SSet.singleton(x))
	end
);


val f_map = organize(fragments, SMap.empty);
SSet.listItems(valOf(SMap.find(f_map, "h")));

