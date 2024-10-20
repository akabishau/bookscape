module UserBooksHelper
  def group_label_for(status)
    {
      "want" => "Want to Read",
      "reading" => "Currently reading",
      "finished" => "Finished Reading",
      "paused" => "Paused",
      "dropped" => "Will not finish"
    }[status]
  end
end
