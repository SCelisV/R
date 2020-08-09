

TabA = as.table(cbind(c("A","B","C"),c(1,2,3)))
# > TabA
#   A B
# A A 1
# B B 2
# C C 3
TabB = as.table(cbind(c("D","E","F"),c(1,2,3)))
# > TabB
#   A B
# A D 1
# B E 2
# C F 3
nams = c(TabA,TabB)
# > nams
# [1] "TabA" "TabB"

for (i in nams){
 print (i)
 tab = get(nams[i])
 print(tab) 
print(get(nams[i]))

}



