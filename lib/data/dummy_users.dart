import 'package:community_connect/model/user.dart';

final users = [
  {'id': 1, 'name': 'Alice Smith', 'username': 'alice_smith'},
  {'id': 2, 'name': 'Bob Johnson', 'username': 'bob_johnson'},
  {'id': 3, 'name': 'Charlie Brown', 'username': 'charlie_brown'},
  {'id': 4, 'name': 'Diana Prince', 'username': 'diana_prince'},
  {'id': 5, 'name': 'Eve Adams', 'username': 'eve_adams'},
  {'id': 6, 'name': 'Frank Miller', 'username': 'frank_miller'},
  {'id': 7, 'name': 'Grace Lee', 'username': 'grace_lee'},
  {'id': 8, 'name': 'Hank Green', 'username': 'hank_green'},
  {'id': 9, 'name': 'Ivy White', 'username': 'ivy_white'},
  {'id': 10, 'name': 'Jack Black', 'username': 'jack_black'},
  {'id': 11, 'name': 'Karen Hill', 'username': 'karen_hill'},
  {'id': 12, 'name': 'Larry Page', 'username': 'larry_page'},
  {'id': 13, 'name': 'Mona Lisa', 'username': 'mona_lisa'},
  {'id': 14, 'name': 'Nina Simone', 'username': 'nina_simone'},
  {'id': 15, 'name': 'Oscar Wilde', 'username': 'oscar_wilde'},
  {'id': 16, 'name': 'Paul Allen', 'username': 'paul_allen'},
  {'id': 17, 'name': 'Quincy Jones', 'username': 'quincy_jones'},
  {'id': 18, 'name': 'Rachel Green', 'username': 'rachel_green'},
  {'id': 19, 'name': 'Steve Jobs', 'username': 'steve_jobs'},
  {'id': 20, 'name': 'Tina Turner', 'username': 'tina_turner'},
  {'id': 21, 'name': 'Uma Thurman', 'username': 'uma_thurman'},
  {'id': 22, 'name': 'Victor Hugo', 'username': 'victor_hugo'},
  {'id': 23, 'name': 'Walt Disney', 'username': 'walt_disney'},
  {'id': 24, 'name': 'Xena Warrior', 'username': 'xena_warrior'},
  {'id': 25, 'name': 'Yara Shahidi', 'username': 'yara_shahidi'},
  {'id': 26, 'name': 'Zara Larsson', 'username': 'zara_larsson'},
  {'id': 27, 'name': 'Aaron Paul', 'username': 'aaron_paul'},
  {'id': 28, 'name': 'Bella Swan', 'username': 'bella_swan'},
  {'id': 29, 'name': 'Chris Evans', 'username': 'chris_evans'},
  {'id': 30, 'name': 'David Tennant', 'username': 'david_tennant'},
  {'id': 31, 'name': 'Elon Musk', 'username': 'elon_musk'},
  {'id': 32, 'name': 'Fiona Apple', 'username': 'fiona_apple'},
  {'id': 33, 'name': 'George Clooney', 'username': 'george_clooney'},
  {'id': 34, 'name': 'Hugh Jackman', 'username': 'hugh_jackman'},
  {'id': 35, 'name': 'Isla Fisher', 'username': 'isla_fisher'},
  {'id': 36, 'name': 'James Bond', 'username': 'james_bond'},
  {'id': 37, 'name': 'Katy Perry', 'username': 'katy_perry'},
  {'id': 38, 'name': 'Leonardo DiCaprio', 'username': 'leonardo_dicaprio'},
  {'id': 39, 'name': 'Megan Fox', 'username': 'megan_fox'},
  {'id': 40, 'name': 'Natalie Portman', 'username': 'natalie_portman'},
];

final userList = users.map((json) => User.fromJson(json)).toList();
