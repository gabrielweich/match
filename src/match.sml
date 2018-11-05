val fragments = ["he","li","be","b","c","n","o","f","ne","na","mg","eco"];
val words = ["cobebo", "liconaneh", "fonenaco", "beco", "helibheco"]

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

fun verifica (word, frgs, i) = true;

val f_map = organize(fragments, SMap.empty);
SSet.listItems(valOf(SMap.find(f_map, "n")));

fun split("", m) = m | split(word, m) = split(String.extract(word, 1, NONE), valOf(SMap.find(f_map, "n"))::m);

List.filter (fn w => verifica(w, split(w, []), 0)) words;