require "rexml/document"
require "date"

puts "На что потратили деньги?"
expense_text = STDIN.gets.chomp

puts "Сколько потратили?"
expense_amount = STDIN.gets.chomp.to_i

puts "Укажите дату траты в формате ДД.ММ.ГГГГ, например 26.07.2022, пустое поле - сегодня"
data_input = STDIN.gets.chomp

expense_date = nil

if data_input == ''
  expense_date = Date.today
else
  expense_date = Date.parse(data_input)
end

puts "В какую категорию занести трату"
expense_category = STDIN.gets.chomp

current_path = File.dirname(__FILE__)
file_name = current_path + "/my_expenses.xml"

file = File.new(file_name, "r:UTF-8")

begin
  doc = REXML::Document.new(file)
rescue REXML::ParseException => e
  puts "XML файл похоже битый :("
  abort e.message
end

file.close

# В expenses переменную сохранили корневой тэг
expenses = doc.elements.find('expenses').first

expense = expenses.add_element 'expense', {
  'amount' => expense_amount,
  'category' => expense_category,
  'date' => expense_date.to_s
}

expense.text = expense_text

file = File.new(file_name, "w:UTF-8")
# Второй аргумент - количество отступов
doc.write(file, 2)
file.close

puts 'Запись успешно сохранена'



























