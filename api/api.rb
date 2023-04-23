require 'socket'

class BugFreeChecker
  def initialize(word, system_parameters)
    @word = word
    @system_parameters = system_parameters
    @invalid_lines = []
  end

  def check_bug_free
    if @word.include?("bug")
      puts "The word contains the word 'bug'!"
      return false
    else
      puts "The word is bug-free!"
      return true
    end
  end

  def check_lines_valid(lines)
    @invalid_lines = []
    lines.each do |line|
      if line.length > @system_parameters[:max_line_length]
        @invalid_lines.push(line)
        puts "Line too long: #{line}"
      elsif line.split.length > @system_parameters[:max_word_count]
        @invalid_lines.push(line)
        puts "Too many words in line: #{line}"
      end
    end
    if @invalid_lines.length > 0
      return false
    else
      puts "All lines are valid!"
      return true
    end
  end

  def check_system_parameters_valid
    if !@system_parameters.has_key?(:max_line_length)
      puts "Missing parameter: max_line_length"
      return false
    elsif !@system_parameters.has_key?(:max_word_count)
      puts "Missing parameter: max_word_count"
      return false
    else
      return true
    end
  end

  def custom_function
    puts "Performing custom function..."
  end

  def start_server(port)
    server = TCPServer.new(port)

    loop do
      client = server.accept
      request = client.gets.chomp

      case request
      when "check_bug_free"
        client.puts(check_bug_free)
      when "check_system_parameters_valid"
        client.puts(check_system_parameters_valid)
      when "get_invalid_lines"
        client.puts(@invalid_lines)
      when "custom_function"
        custom_function
        client.puts("Custom function performed.")
      else
        client.puts("Invalid request.")
      end

      client.close
    end
  end
end
