

RSpec.describe "Regex test" do

  BData = [
    # beginning
    "C",
    "c-hyphen",
    "C-hyphen-capital",
    "c.dot",
    "C.dot.capital",
    "c space",
    "C space capital",
    "c_underscore",
    "C_underscore_capital",
    "c!",
    "c?",
    "character cat",
  ]

  MData = [
    # middle
    "the-c-hyphen",
    "the-C-hyphen-capital",
    "the.c.dot",
    "the.C.dot.capital",
    "the c space",
    "the C space capital",
    "the_c_underscore",
    "the_C_underscore_capital",

    "[the-c-hyphen]",
    "the-[c-hyphen]",
    "the-[c]-hyphen",
    "(the-c-hyphen)",
    "the-(c-hyphen)",
    "the-(c)-hyphen",

    "the-|c|-hyphen",
    "the-|c-hyphen|",

    "the-\"c\"-hyphen",
    "the-\"c-hyphen\"",
    "the-'c-hyphen'",
    
    "practice make perfect"
  ]

  EData = [
    "hyphen-to-c",
    "Hyphen-to-capital-c",
    "dot.to.c",
    "dot.to.capital.C",
    "space to c",
    "space to capital C",
    "underscore_to_c",
    "underscore_to_capital_C",

    "hyphen-to-c-",
    "Hyphen-to-capital-c-",
    "dot.to.c.",
    "dot.to.capital.C.",
    "space to c ",
    "space to capital C ",
    "underscore_to_c_",
    "underscore_to_capital_C_",


    "hyphen-[to-c]",
    "hyphen-[to_c]",
    "hyphen-[to.c]",
    "hyphen-[to c]",
    "hyphen-(to-c)",
    "hyphen-(to_c)",
    "hyphen-(to.c)",
    "hyphen-(to c)",

    "hyphen-to-[c]",
    "hyphen-to-(c)",
    "hyphen-to-c)",
    
    "hyphen-to|c",
    "hyphen-to|c|",

    "screw garlic",
    "hyphen-to-garlic)",
  ]

  Key = "c"

  it 'selects result with leading key' do
    res = BData.select do |v|
      v =~ /^#{Key}[-,.,_,\s,\W]/i or
      v =~ /^#{Key}\z/i
    end
    p res
    expect(res.length == BData.length-1).to be true
  end

  it 'selects result with middle key' do
    res = MData.select do |v|
      v =~ /[-,.,_,|,\s,\W]#{Key}[-,.,_,|,\s,\W]/i
    end
    p res
    expect(res.length == MData.length-1).to be true
  end

  it 'selects result with ending key' do
    res = EData.select do |v|
      v =~ /[-,.,_,|,\s]#{Key}\z/i or
      #v =~ /[-,.,_,|,\s,\[,\(]#{Key}[\],\)]/i 
      v =~ /[-,.,_,|,\s,\W]#{Key}[-,.,_,|,\s,\W]\z/i 
    end
    p res
    expect(res.length == EData.length-2).to be true
  end

  it 'combines all search' do
    input = []
    input += EData
    input += BData
    input += MData
    input.sort

    res = input.select do |v|
      # beginning
      v =~ /^#{Key}[-,.,_,\s\W]/i or
      v =~ /^#{Key}\z/i or
      
      # middle
      v =~ /[-,.,_,|,\s,\W]#{Key}[-,.,_,|,\s,\W]/i or
      
      # end
      v =~ /[-,.,_,|,\s]#{Key}\z/i or
      v =~ /[-,.,_,|,\s,\W]#{Key}[-,.,_,|,\s,\W]\z/i 
    end
    p res
    expect(res.length == input.length-4).to be true
  end

end
