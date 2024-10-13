require_relative './lib/hashmap.rb'

hash = HashMap.new

hash.set("Messi", "Barcelone")
hash.set("kaka", "Milan AC")
hash.set("Del Pierro", "Juventus")
hash.set("Modric", "Real Madrid")
hash.set("pele", "Santos")
hash.set("Tresor Mputu", "TP Mazembe")
hash.set("Drogba", "chelsea")
hash.set("ETo'o", "ANzhi")
hash.set("Yaya Toure", "Ivory Coast")
hash.set("Onana", "Manchester united")
hash.set("Song", "Arsenal")

p hash.length

p hash.has("kaka")
#  hash.remove("Messi")
hash.set("Messi", "Argentina")
p hash.get("Messi")
p hash.values