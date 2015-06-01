module CakeCodingExercise::Helpers
  def has_many(association)
    subject.save

    expect {
      subject.send(association).create
    }.to change {
      subject.send(association).count
    }.by(1)
  end

  # This should use some factories to build a valid instance.
  # So we would do just FactoryGirl.build("valid_#{association}")
  # and we wouldn't need the instance argument.
  def belongs_to(association, instance)
    subject.send("#{association}=", instance)
    expect(subject.send(association)).to eq(instance)
  end
end
