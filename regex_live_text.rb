
Mode = :strict
name = "windows"

found = Dir.glob(File.join("/mnt/WinVault/Alexandrial/Technical", "**/**")).reject { |f| File.directory?(f) }.select { |v| 

  vv = File.basename(v)
  case Mode
  when :strict
    
    res1 = (/^#{name}[-,_,.,\s]/i =~ vv)
    res2 = (vv =~ /[\(,-,_,.,\s]#{name}[\),-,_,.,\s]/i)
    res3 = (vv =~ /[-,_,.,\s]#{name}\z/i)

    puts "#{vv} : #{res1} / #{res2} / #{res3}"

    (res1 or res2 or res3)

  else

    res1 = (vv =~ /[(,-,_,.,\s]#{name}[),-,_,.,\s]/i)
    res2 = (vv =~ /[(,-,_,.,\s]#{name}/i)
    res3 = (vv =~ /#{name}[),-,_,.,\s]/i)

    puts "#{vv} : #{res1} / #{res2} / #{res3}"
    (res1 or res2 or res3)
  end

}

p found

