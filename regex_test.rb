
t = []
#t << "art-of-computer-programming-"
#t << "the-art-of-programming"
#t << "the.art.of.programming"
#t << "the_art_of_programming"
#t << "art.of.taling"
#t << "whatever there"
#t << "art of whatever"
#t << "tart.is.delicious"
#t << "the-art.of-sing"
#t << "nothing here"
#t << " art-anter"
#t << "Bug Bounty Playbook"
#t << "the art"
#t << "this  is (art) of bounty"

# test beginning
t << "r-cookbook-oreilly-cookbooks"
t << "r.dotbook"
t << "R.dotbook"
t << "r space"
# test middle
t << "using-r-for-data-analysis-in-social-sciences"
t << "using.r.for.data.analysis.in.social.sciences"
t << "using r for data analysis in social sciences"
t << "protein is doomed"
t << "protein-is-doomed"
t << "protein.is.doomed"
t << "ginger sings"
t << "ginger-sings"
t << "ginger.sings"
t << "the-earth-is-round"
# test end
t << "a-data-scientists-guide-to-acquiring-cleaning-and-managing-data-in-r"

name = "r"
lead = t.select { |v| 
  #v =~ /#{name}[-,.,_,\s]/ or
  #v =~ /[-,.,_,\s,^]#{name}[-,.,_,\s]/ or
  #v =~ /[-,.,_,\s]#{name}\z/ 

  v =~ /^#{name}[-,.,_,\s]/i

}
puts "lead length : #{lead.length}"

p res1

#res2 = t.select do |v|
#  v =~ /[-,.,_,\s]#{name}[-,.,_,\s,\z]/i
#end
#puts "res2 length : #{res2.length}"
#p res2


