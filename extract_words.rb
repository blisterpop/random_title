require 'set'

def extract_words(infile, outfile)
  # Skip Princeton copyright statement
  words = File.readlines(infile).drop(29).map { |line|
    line.split(' ')[4].strip
  }
  File.open(outfile, 'w') { |f|
    words.each { |w| f.puts(w) }
  }
end

extract_words('data.adj', 'adjectives.txt')
extract_words('data.noun', 'nouns.txt')

def extract_common_words(word_class_file, outfile)
  word_class = File.readlines(word_class_file).select { |w|
    w[0] >= 'a' && w[0] <= 'z'  # Exclude proper nouns
  }.map(&:downcase).map(&:strip).to_set
  common = File.readlines('google-10000-english.txt').map(&:strip).select { |w|
    w.length >= 3   # Exclude very short words
  }
  common_words = common.select { |w| word_class.include?(w) }
  File.open(outfile, 'w') { |f|
    common_words.each { |w| f.puts(w) }
  }
end

extract_common_words('adjectives.txt', 'common_adjectives.txt')
extract_common_words('nouns.txt', 'common_nouns.txt')

def word_list_to_js_array(infile)
  words = File.readlines(infile).map(&:strip)
  elements = words.map { |w|
    "'#{w}'"
  }.join(',')
  "[#{elements}]"
end

def write_js_arrays
  adjectives = word_list_to_js_array('common_adjectives.txt')
  nouns = word_list_to_js_array('common_nouns.txt')
  puts "COMMON_ADJECTIVES=#{adjectives};"
  puts "COMMON_NOUNS=#{nouns};"
end

write_js_arrays
