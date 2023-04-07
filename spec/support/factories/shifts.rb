Factory.define(:shift) do |f|
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
