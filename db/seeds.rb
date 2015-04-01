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
u = User.create(username: 'petey', email: 'pt@live.in', password: 'mudkip', password_confirmation: 'mudkip', is_admin: true, college: 'Techno India', name: 'Soham Pal', balance: 5000, gender: 'male')

# Add sample programs
(1..5).each do |i|
  p1 = Problem.create(name: 'Print Numbers ' + i.to_s + '-1', difficulty: 1, statement: '<p>Print the integer that has been entered.</p><br><h4>Input format</h4><p>The first like contains the number of test cases, <b>T</b>. Each test case consists of a single integer.</p><br><h4>Output format</h4><p>Each output is a single integer.</p>', sample_input: "3\n1\n2\n3", sample_output: "1\n2\n3", test_case_inputs: "1;\n2;\n3;\n4;\n5;\n6;\n7;\n8;\n9;\n10", test_case_outputs: "1;\n2;\n3;\n4;\n5;\n6;\n7;\n8;\n9;\n10", reward: 100,  base_price: 20 );
  p2 = Problem.create(name: 'Print Numbers ' + i.to_s + '-2', difficulty: 2, statement: '<p>Print the integer that has been entered.</p><br><h4>Input format</h4><p>The first like contains the number of test cases, <b>T</b>. Each test case consists of a single integer.</p><br><h4>Output format</h4><p>Each output is a single integer.</p>', sample_input: "3\n1\n2\n3", sample_output: "1\n2\n3", test_case_inputs: "1;\n2;\n3;\n4;\n5;\n6;\n7;\n8;\n9;\n10", test_case_outputs: "1;\n2;\n3;\n4;\n5;\n6;\n7;\n8;\n9;\n10", reward: 1500, base_price: 400);
  p3 = Problem.create(name: 'Print Numbers ' + i.to_s + '-3', difficulty: 3, statement: '<p>Print the integer that has been entered.</p><br><h4>Input format</h4><p>The first like contains the number of test cases, <b>T</b>. Each test case consists of a single integer.</p><br><h4>Output format</h4><p>Each output is a single integer.</p>', sample_input: "3\n1\n2\n3", sample_output: "1\n2\n3", test_case_inputs: "1;\n2;\n3;\n4;\n5;\n6;\n7;\n8;\n9;\n10", test_case_outputs: "1;\n2;\n3;\n4;\n5;\n6;\n7;\n8;\n9;\n10", reward: 2500, base_price: 700);

  FreePoolItem.create(problem: p1)
  Auction.create(problem: p2, active: nil, winning_bid: nil, end_time: nil)
  Auction.create(problem: p3, active: nil, winning_bid: nil, end_time: nil)
end
