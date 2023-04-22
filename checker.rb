class BugFreeChecker
  def initialize(word, system_parameters)
    @word = word
    @system_parameters = system_parameters
  end

  def check_bug_free
    if @word.include?("bug")
      puts "The word '#{@word}' is not bug-free."
      return false
    else
      puts "The word '#{@word}' is bug-free."
      return true
    end
  end

  def check_lines_valid(lines)
    max_line_length = @system_parameters[:max_line_length]
    max_word_count = @system_parameters[:max_word_count]
    invalid_lines = lines.select { |line| line.length > max_line_length || line.split.size > max_word_count }

    if invalid_lines.any?
      puts "The following lines are invalid:"
      puts invalid_lines
      return false
    else
      puts "The lines are valid."
      return true
    end
  end

  def check_system_parameters_valid
    valid = true

    if @system_parameters[:max_line_length].nil?
      puts "max_line_length system parameter is missing."
      valid = false
    end

    if @system_parameters[:max_word_count].nil?
      puts "max_word_count system parameter is missing."
      valid = false
    end

    return valid
  end

  def custom_function
    puts "This is a custom function that does something else!"
  end
end

# Sample usage
system_parameters = {
  max_line_length: 79,
  max_word_count: 13
}
checker = BugFreeChecker.new("garbanzo", system_parameters)
lines = [
  "Garbanzo beans are also known as chickpeas,",
  "and they are a popular ingredient in many",
  "cuisines around the world. They are rich in",
  "protein, fiber, and various vitamins and minerals."
]
if checker.check_system_parameters_valid
  checker.check_bug_free
  checker.check_lines_valid(lines)
  checker.custom_function
end
