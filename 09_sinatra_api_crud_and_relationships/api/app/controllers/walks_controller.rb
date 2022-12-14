class WalksController < ApplicationController

  get "/walks" do 
    options = get_walk_json_config(include_dogs: params.include?("include_dogs"))
    Walk.all.to_json(options)
  end

  get "/walks/recent" do 
    options = get_walk_json_config(include_dogs: params.include?("include_dogs"))
    Walk.recent.to_json(options)
  end

  get "/walks/:id" do 
    walk = Walk.find(params[:id])
    options = get_walk_json_config(include_dogs: true)
    walk.to_json(options)
  end

 
  # ✅ we want to be able to create walks through the API
  post "/walks" do 
    # create the walk and at the same time we want to create the dog_walks
    # take the ids of the dogs and we want association with those ids
    walk = Walk.create(walk_params)
    options = get_walk_json_config(include_dogs: true)
    walk.to_json(options)
  end

  # ✅ we want to be able to update walks through the API
  patch "/walks/:id" do 
    walk = Walk.find_by(id: params[:id])
    binding.pry
    return status 404 if walk.nil?
    walk.update(walk_params)
    options = get_walk_json_config(include_dogs: true)
    walk.to_json(options)

  end

  # ✅ we want to be able to delete walks through the API
  delete "/walks/:id" do 
    walk = Walk.find_by(id: params[:id])

    options = get_walk_json_config(include_dogs: true)
    walk.destroy
  end

  private 

  # a method used to specify which keys are allowed through params into the controller
  # we use this method to create a list of what's permitted to be passed to .create or .update
  # within controller actions.
  def walk_params
    allowed_params = %w(time dog_ids)
    params.select {|param,value| allowed_params.include?(param)}
  end
  
  def get_walk_json_config(include_dogs: false)
    options = {
      methods: [:formatted_time]
    }
    if include_dogs
      options.merge!({
        include: {
          dogs: {
            methods: [:age]
          }
        }
      }) 
    end
    options
  end

end