class PersonalitiesController < ApplicationController
  def index
    user_id = current_user.id
    @profile = Profile.find_by user_id: user_id
  end

  def myersBriggs
    #Retrieves current user’s myer’s briggs personality type
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    mbptype = @userProfile.ptmyersbriggs
    #List of good and ideal matches for first 8 personality types
    top8 = ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP"]
    #List of good and ideal matches for middle 4 personality types
    middle4 = ["INTJ", "ENTJ", "INTP", "ENTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ"]
    #List of good and ideal matches for bottom 4 personality types
    bottom4 = ["ISFJ", "ESFJ", "ISTJ", "ESTJ"]

    def ReturnMatches(matches)
      return Profile.where(ptmyersbriggs: matches)
    end
    #Queries profile database with list of great matches, removes ideal matches from list
    def ReturnMatchesDouble(matches1, matches2)
      matches2 -= matches1
      return Profile.where(ptmyersbriggs: matches2)
    end

    case mbptype
      when "INFP"
      idealMatches = ["ENFJ", "ENTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "ENFP"
      idealMatches = ["INFJ", "INTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "INFJ"
      idealMatches = ["ENFP", "ENTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "ENFJ"
      idealMatches = ["INFP", "ISFP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "INTJ"
      idealMatches = ["ENFP", "ENTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "ENTJ"
      idealMatches = ["INFP", "INTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "INTP"
      idealMatches = ["ENTJ", "ESTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "ENTP"
      idealMatches = ["INFJ", "INTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, top8)
      when "ISFP"
      idealMatches = ["ENFJ", "ESFJ", "ESTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      when "ESFP"
      idealMatches = ["ISFJ", "ISTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      when "ISTP"
      idealMatches = ["ESFJ", "ESTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      when "ESTP"
      idealMatches = ["ISFJ", "ISTJ"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatchesDouble(idealMatches, middle4)
      when "ISFJ"
      idealMatches = ["ESFP", "ESTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      when "ESFJ"
      idealMatches = ["ISFP", "ISTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      when "ISTJ"
      idealMatches = ["ESFP", "ESTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      when "ESTJ"
      idealMatches = ["INTP", "ISFP", "ISTP"]
      @idealMatches = ReturnMatches(idealMatches)
      @goodMatches = ReturnMatches(bottom4)
      else
        redirect_to(personalities_path, {:flash => {:red => 'Profile must have MB test filled out to view this page.'}})
    end
  end

  def conflictManagement
    #Retrieves current user’s conflict management type
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    crType = @userProfile.ptanimal
    #Returns a list of users who have the same conflict animal as the user
    @sameCM = Profile.where(ptanimal: crType)
    @foxCM = nil
    if crType != "The Compromising Fox"
      #Returns a list of users who have the fox conflict animal
      @foxCM = Profile.where(ptanimal: "The Compromising Fox")
    elsif crType == "-"
      redirect_to(personalities_path, {:flash => {:red => 'Profile must have result of Conflict Resolution test filled out to view this page.'}})
    end
    #Depending on the user's conflict animal, returns a list of users who have the opposite type
    case crType
    when "The Compromising Fox"
      allAnimals = ["The Competitive Shark", "The Collaborative Owl", "The Avoidant Turtle", "The Accommodating Teddy Bear"]
      @oppositeMatches = Profile.where(ptanimal: Allanimals)
    when "The Competitive Shark"
      oppositeAnimal = ["The Accommodating Teddy Bear"]
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
    when "The Collaborative Owl"
      oppositeAnimal = ["The Avoidant Turtle"]
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
    when "The Avoidant Turtle"
      oppositeAnimal = ["The Collaborative Owl"]
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
    when "The Accommodating Teddy Bear"
      oppositeAnimal = ["The Competitive Shark"]
      @oppositeMatches = Profile.where(ptanimal: oppositeAnimal)
    end
  end

  def trueColors
    #Retrieves current user’s profile
    user_id = current_user.id
    @userProfile = Profile.find_by user_id: user_id
    if (@userProfile.pttruecolors == "-")
      redirect_to(personalities_path, {:flash => {:red => 'Profile must have result of true colors test filled out to view this page.'}})
    end
    #Because there is no defined compatibility online, will just query database for users of all types
    @blueProfiles = Profile.where(pttruecolors: "Blue")
    @goldProfiles = Profile.where(pttruecolors: "Gold")
    @greenProfiles = Profile.where(pttruecolors: "Green")
    @orangeProfiles = Profile.where(pttruecolors: "Orange")
  end

  def enneagram
  end
end
