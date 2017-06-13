require 'json'
require 'csv'



players_data = []
CSV.foreach('feeds/epl_data.csv') do |row|
  players_data << row
end

players_data.shift
player_count = 1

team_shortnames = ['ARS','BOU','BUR','CHE','CRY','EVE','HUL','LEI','LIV','MCI','MUN','MID','SOU','STK','SUN','SWA','TOT','WAT','WBA','WHU']
team_names = ['Arsenal', 'Bournemouth','Burnley','Chelsea','Crystal Palace','Everton','Hull City','Leicester City','Liverpool','Manchester City','Manchester United','Middlesbrough','Southampton','Stoke City','Sunderland','Swansea City','Tottenham','Watford','West Bromwich Albion','West Ham United']
team_colors = ['#cf1043','#C01115','#6a003a','#0a4595','#eb302e','#00369c','#faa61a','#273e8a','#e31b23','#6caee0','#d81920','#fd1a21','#d71920','#d71f30','#e31c23','#f5f5f5','#131f53','#ffee00','#102d69','#7d2c3b']

namespace :data do

  task teams: :environment do
    puts('Creating Teams')
    (0..19).each do |i|
      Team.create(short_name: team_shortnames[i],club_name:team_names[i],color: team_colors[i])
      print('.')
    end
  end

  task players: :environment do
    puts('Creating Players')
    players_data.each do |player|
      team = Team.find_by_short_name(player[3])
      Player.create(first_name: (player[0] || ''),last_name:(player[1] || ''), team_id: team.id, position: player[2])
      print('.')
    end
  end

  task stats: :environment do
    puts('Creating Disciplinary records')
    players_data.each do |player|
      PlayerStatistic.create(player_id: player_count, goals:(player[17] ||0), assists: (player[32]||0),minutes_played: (player[39]||0), saves:(player[15]||0), yellow_cards: (player[12] || 0), red_cards: (player[42] || 0), points:(player[6] || 0))
      player_count = player_count + 1
      print ('.')
    end
  end


  task load_all: :environment do |t, args|
    old_session = Sunspot.session
    Sunspot.session = Sunspot::Rails::StubSessionProxy.new(Sunspot.session)
    [:teams,:players,:stats].each do |task_name|
      Rake::Task["data:#{task_name}"].invoke
    end
    Sunspot.session=old_session
    Rake::Task['sunspot:reindex'].invoke
  end
end
