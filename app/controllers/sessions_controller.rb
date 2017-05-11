class SessionsController <ApplicationController

def new
end

def create
  @teacher = Teacher.find_by(email: session_params["email"])

  if @teacher.authenticate(session_params["password"]) == @teacher

    login(@teacher)
    redirect_to root_path
  else
    if @teacher.authenticate(session_params["password"]) == false
      @errors = ["Password or Email is invalid"]
    else
      @errors = @teacher.errors.full_messages
    end
    render 'new'
  end

end

def destroy
  logout
  redirect_to root_path
end

private

def session_params
  p"*" * 100
  p params
  p"*" * 100

  params.require(:session).permit(:email, :password)
end
end
