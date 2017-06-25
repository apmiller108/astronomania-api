FactoryGirl.define do
  factory :asteroid_close_approach, class: 'Asteroid::CloseApproach' do
    close_approach_date '1945-06-07'
    epoch_date_close_approach '-775328400000'
    relative_velocity(
      "kilometers_per_second" => 15.5095198576,
      "kilometers_per_hour" => 55_834.2714874122,
      "miles_per_hour" => 34_693.2449694979
    )
    miss_distance(
      "astronomical" =>  0.0334263473,
      "lunar" => 13.0028495789,
      "kilometers" => 5_000_510.5,
      "miles" => 3_107_173.25
    )
    orbiting_body "Mars"
  end
end
