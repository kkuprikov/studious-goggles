Factory.define(:shift) do |f|
  f.day '2023-01-01'
  f.trait :morning_shift do |f|
    f.interval 0
  end

  f.trait :day_shift do |f|
    f.interval 1
  end

  f.trait :evening_shift do |f|
    f.interval 2
  end
end
