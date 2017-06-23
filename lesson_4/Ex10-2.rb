munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  x = munsters[key]['age']
  if x < 18 
    munsters[key]['age_group'] = 'kid'
  elsif x >= 65 
    munsters[key]['age_group'] = 'senior'
  else 
    munsters[key]['age_group'] = 'adult'
  end
end

p munsters