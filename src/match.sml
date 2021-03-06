(*
    Autor: Gabriel Weich
    Linguagem: Standard ML of New Jersey v110.84
    Data: 06/11/2018
*)



(* Leitura e escrita de arquivos *)
(* https://learnxinyminutes.com/docs/standard-ml/ *)

fun read(filename) =
    let val file = TextIO.openIn filename
        val content = TextIO.inputAll file
        val _ = TextIO.closeIn file
    in String.tokens (fn c => c = #"\n") content
    end

fun write_results(filename, results) =
    let val file = TextIO.openOut(filename)
        val _ = TextIO.output(file, (String.concatWith "\n" results))
    in TextIO.closeOut(file)
    end



fun clean array = List.filter (fn w => List.all Char.isAscii (String.explode(w))) array
fun lower array = map (fn x => String.implode (map (fn y => Char.toLower(y)) (String.explode x))) array

val fragments = lower (clean (read "fragments.txt"))
val words = lower (clean (read "words.txt"))


(* Utilização de estruturas Map e Set *)
(* https://www.it.uu.se/edu/course/homepage/funpro/ht07/handout/f10-stdlib.html *)
(* http://www.cs.cornell.edu/courses/cs312/2007fa/recitations/rec09.html *)

structure StringKey =
struct
    type ord_key = string
    val compare = String.compare
end

structure SMap = RedBlackMapFn(StringKey)
structure SSet = RedBlackSetFn(StringKey)


fun organize_fragments ([], m) = m | organize_fragments (x::xs, m) = organize_fragments(xs,
	let
		val c = Char.toString(String.sub(x, 0))
	in
		if SMap.inDomain(m, c)
		then SMap.insert(m, c, SSet.add(valOf(SMap.find(m, c)),x))
		else SMap.insert(m, c, SSet.singleton(x))
	end
)


(* Utilização de referência, atribuição e deferência *)
(* https://learnxinyminutes.com/docs/standard-ml/ *)

(* Sintaxe de operadores *)
(* http://rigaux.org/language-study/syntax-across-languages-per-language/SML.html *)

(* Uso do while *)
(* https://stackoverflow.com/questions/7548139/sml-nj-while-loop *)
(* http://homepages.inf.ed.ac.uk/stg/NOTES/node87.html *)

fun match(word, frgs, i) =
    let
        val found = ref false
        val nfrgs = ref(frgs)
        val ss = ref(List.nth(!nfrgs, i))
    in
        while not(!found) andalso i >= 0 andalso i < size(word) andalso not(SSet.isEmpty(!ss))
        do let
            val f = List.nth(SSet.listItems(!ss), 0)
            val e = i + size(f)
        in
            if e <= size(word) andalso String.substring(word, i, size(f)) = f
            then
                if e = size(word) orelse match(word, !nfrgs, e)
                then found := true
                else let in ss:=SSet.delete(!ss, f);nfrgs := List.take(!nfrgs, i) @ [!ss] @ List.drop(!nfrgs, i+1) end
            else let in ss:=SSet.delete(!ss, f);nfrgs := List.take(!nfrgs, i) @ [!ss] @ List.drop(!nfrgs, i+1) end
        end;
    !found
    end


(* Demais operadores *)
(* http://sml-family.org/Basis/overview.html *)

val f_map = organize_fragments(fragments, SMap.empty)

fun organize_words("", m) = m |
    organize_words(word, m) = organize_words(String.extract(word, 1, NONE),
    m@[if SMap.inDomain(f_map, String.substring(word, 0, 1)) then valOf(SMap.find(f_map, String.substring(word, 0, 1))) else SSet.empty]);

write_results("results.txt", (List.filter (fn w => match(w, organize_words(w, []), 0)) words));