# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Add settings rows
ConfigTable.create(key: 'test_case_limit', value: 5)
ConfigTable.create(key: 'submission_time_limit', value: 120)

# Add a user
u = User.create(username: 'petey', email: 'pt@live.in', password: 'mudkip', password_confirmation: 'mudkip', is_admin: true, college: 'Techno India', name: 'Soham Pal', score: 0, gender: 'male')

# Add sample programs
(1..15).each do |i|
  Problem.create(name: 'Print Numbers ' + i.to_s + '-1', difficulty: 1, statement: '<p>Print the integer that has been entered.</p><br><h4>Input format</h4><p>The first like contains the number of test cases, <b>T</b>. Each test case consists of a single integer.</p><br><h4>Output format</h4><p>Each output is a single integer.</p>', sample_input: "3\n1\n2\n3", sample_output: "1\n2\n3", test_case_inputs: "1;\n2;\n3;\n4;\n5;\n6;\n7;\n8;\n9;\n10", test_case_outputs: "1;\n2;\n3;\n4;\n5;\n6;\n7;\n8;\n9;\n10", reward: 50);
  Problem.create(name: 'Print Numbers ' + i.to_s + '-2', difficulty: 2, statement: '<p>Print the integer that has been entered, plus 1.</p><br><h4>Input format</h4><p>The first like contains the number of test cases, <b>T</b>. Each test case consists of a single integer.</p><br><h4>Output format</h4><p>Each output is a single integer.</p>', sample_input: "3\n1\n2\n3", sample_output: "2\n3\n4", test_case_inputs: "1;\n2;\n3;\n4;\n5;\n6;\n7;\n8;\n9;\n10", test_case_outputs: "2;\n3;\n4;\n5;\n6;\n7;\n8;\n9;\n10;\n11", reward: 100);
end
