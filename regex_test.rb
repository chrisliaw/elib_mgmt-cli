
t = []
t << "art-of-computer-programming-"
t << "the-art-of-programming"
t << "the.art.of.programming"
t << "the_art_of_programming"
t << "art.of.taling"
t << "whatever there"
t << "art of whatever"
t << "tart.is.delicious"
t << "the-art.of-sing"
t << "nothing here"
t << " art-anter"
t << "Bug Bounty Playbook"
t << "the art"
t << "this  is (art) of bounty"
t << "r-quick-syntax-reference.9781430266402.65848"
t << "r-cookbook-oreilly-cookbooks"
t << "using-r-for-data-analysis-in-social-sciences.9780190656225.90561"
t << "a-data-scientists-guide-to-acquiring-cleaning-and-managing-data-in-r.9781119080022.73583"

name = "r"
p t.select { |v| 
  v =~ /#{name}[-,.,_,\s]/ or
  v =~ /[-,.,_,\s]#{name}[-,.,_,\s]/  or
  v =~ /[-,.,_,\s]#{name}\z/ 
  #v =~ /^#{name}[-,.,_,\s]/i 
  #v =~ /[\(,\),-,.,_,\s]r[\(,\),-,.,_,\s]/  or
  #v =~ /[\(,\),-,.,_,\s]r\z/ 
  #v =~ /[-,.,_,\s]program\w+[-,.,_,\s]/ or
  #v =~ /program\w+[-,.,_,\s]/ or
  #v =~ /[-,.,_,\s]program\w+/ 
  #v =~ /[-,.,_,\s]bounty\w*[-,.,_,\s]/i
  #v =~ /[-,.,_,\s]art\z/ 
  #v =~ /^art[-,.,_,\s]/ 
}

