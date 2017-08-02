# Word Cloud Plot for Reviews
Reviews = read.csv("Reviews_Final.csv", stringsAsFactors = F)

Word_Counts = unique(Reviews$Top10_Adjectives)
# Assign the Top10_Adjectives column to Word_Counts

Word_Counts = sapply(Word_Counts, function(x) strsplit(x, ","))
# Splitting up the long string delimited by comma 
Word_Counts = unname(Word_Counts)
# Removing the weird looking names so that I can rename them in the next step
names(Word_Counts) = unique(Reviews$Show_Name)
# Rename each list element so I can easily refer to them

Word_Counts = lapply(Word_Counts, function(x) gsub("\\'|\\)|\\]|\\(|\\[", "", x))
# replacing " ", "'", ")", "]", "(", "[" with an empty string

WC_Words = lapply(Word_Counts, function(x) x[seq(1, length(x), by = 2)])
# Extracting only the words out from the vector-- sequence of all the odd elements
WC_Counts = lapply(Word_Counts, function(x) x[seq(2, length(x), by = 2)])
# Extracting only the counts out from the ector-- sequence of all the even elements


Hamilton_wordcloud = wordcloud(unlist(WC_Words["Hamilton"]), as.numeric(unlist
          ((WC_Counts["Hamilton"]))), min.freq =3, scale=c(5, .8), random.order = F, 
          random.color = F, colors= c("indianred1","indianred2","indianred3","indianred"), 
          rot.per = 0)
# Word Cloud for Hamilton
Hansen_wordcloud = wordcloud(unlist(WC_Words["Dear Evan Hansen"]), as.numeric(unlist
    ((WC_Counts["Dear Evan Hansen"]))), min.freq =3, scale=c(5, .8), random.order = F, random.color = F, 
      colors= c("royalblue1","royalblue2","royalblue3","royalblue"), rot.per = 0)
# Word Cloud for Dear Evan Hansen
Wicked_wordcloud = wordcloud(unlist(WC_Words["Wicked"]), as.numeric(unlist
    ((WC_Counts["Wicked"]))), min.freq =3, scale=c(5, .8), random.order = F, random.color = F, 
    colors= c("seagreen1","seagreen2","seagreen3","seagreen"), rot.per = 0)
# Word Cloud for Wicked

Lion_wordcloud = wordcloud(unlist(WC_Words["The Lion King"]), as.numeric(unlist
    ((WC_Counts["The Lion King"]))), min.freq =3, scale=c(5, .8), random.order = F, random.color = F, 
    colors= c("darkorange1","darkorange2","darkorange3","darkorange"), rot.per = 0)
# Word Cloud for Lion King

Charlie = wordcloud(unlist(WC_Words["Charlie and the Chocolate Factory"]), as.numeric(unlist
  ((WC_Counts["Charlie and the Chocolate Factory"]))), min.freq =3, scale=c(5, .8), random.order = F, random.color = F, 
  colors= c("darkgoldenrod","darkgoldenrod2","darkgoldenrod3","darkgoldenrod1"), rot.per = 0)
# Word Cloud for Charlie and the Chocolate Factory
WarPaint_wordcloud = wordcloud(unlist(WC_Words["War Paint"]), as.numeric(unlist
  ((WC_Counts["War Paint"]))), min.freq =3, scale=c(5, .8), random.order = F, random.color = F, 
  colors= c("dodgerblue","dodgerblue2","dodgerblue3","dodgerblue4"), rot.per = 0)
# Word Cloud for War Paint

