require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  fixtures :surveys, :questions, :answers

  setup do
    @survey = surveys(:programming)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create survey" do
    assert_difference(['Survey.count', 'Question.count']) do
      assert_difference('Answer.count', 2) do
        post :create, params: { survey: {
          name: "Programming languages",

          questions_attributes: {
            "0" => {
              content: "Which language allows closures?",

              answers_attributes: {
                "0" => { content: "Ruby Programming Language" },
                "1" => { content: "CSharp Programming Language" },
              }
            }
          }
        } }
      end
    end

    survey = Survey.last
    assert_equal "Programming languages", survey.name
    assert_equal "Which language allows closures?", survey.questions.first.content
    assert_equal 2, survey.questions.first.answers.size

    assert_redirected_to survey_path(survey)
    assert_match /was successfully created/, flash[:notice]
  end

  test "should create dynamically added question to a survey" do
    assert_difference('Question.count', 2) do
      post :create, params: { survey: {
        name: "Programming languages",

        questions_attributes: {
          "0" => {
            content: "Which language allows closures?",

            answers_attributes: {
              "0" => { content: "Ruby Programming Language" },
              "1" => { content: "CSharp Programming Language" },
            }
          },

          "12343" => {
            content: "Which language allows objects?",

            answers_attributes: {
              "0" => { content: "Ruby Programming Language" },
              "1" => { content: "C Programming Language" },
            }
          }
        }
      } }
    end

    survey = Survey.last
    assert_equal 2, survey.questions.size

    assert_redirected_to survey_path(survey)
    assert_match /was successfully created/, flash[:notice]
  end

  test "should create dynamically added answer to a question" do
    assert_difference('Answer.count', 3) do
      post :create, params: { survey: {
        name: "Programming languages",

        questions_attributes: {
          "0" => {
            content: "Which language allows closures?",

            answers_attributes: {
              "0" => { content: "Ruby Programming Language" },
              "1" => { content: "CSharp Programming Language" },
              "12322" => { content: "C Programming Language" }
            }
          }
        }
      } }
    end

    survey = Survey.last
    assert_equal 3, survey.questions.first.answers.size

    assert_redirected_to survey_path(survey)
    assert_match /was successfully created/, flash[:notice]
  end

  test "should not create survey with invalid params" do
    assert_difference('Survey.count', 0) do
      post :create, params: { survey: {
        name: @survey.name,

        questions_attributes: {
          "0" => {
            content: nil,

            answers_attributes: {
              "0" => { content: "Ruby Programming Language" },
              "1" => { content: nil },
            }
          }
        }
      } }
    end

    assert_response :success
  end

  test "should show survey" do
    get :show, params: { id: @survey }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @survey }
    assert_response :success
  end

  test "should update survey" do
    assert_difference('Survey.count', 0) do
      patch :update, params: { id: @survey, survey: {
        name: "Native languages",

        questions_attributes: {
          "0" => {
            content: "Which language is spoken in England?",
            id: questions(:one).id,

            answers_attributes: {
              "0" => { content: "The English Language", id: answers(:ruby).id },
              "1" => { content: "The Latin Language", id: answers(:cs).id },
            }
          },
        }
      } }
    end

    @survey.reload
    assert_equal "Native languages", @survey.name
    assert_equal "Which language is spoken in England?", @survey.questions.first.content

    assert_redirected_to survey_path(@survey)
    assert_match /was successfully updated/, flash[:notice]
  end

  test "should destroy dynamically removed question from survey" do
    survey = Survey.create!(name: "Oral languages")
    q1 = survey.questions.create!(content: "Which language is spoken in England?")
    q2 = survey.questions.create!(content: "Which language is spoken in America?")
    q1.answers.create!(content: "English")
    q1.answers.create!(content: "Latin")
    q2.answers.create!(content: "English")
    q2.answers.create!(content: "American")

    assert_difference('Question.count', -1) do
      patch :update, params: { id: survey, survey: {
        name: "Native languages",

        questions_attributes: {
          "0" => {
            content: "Which language is spoken in England?",
            id: q1.id,

            answers_attributes: {
              "0" => { content: "The English Language", id: q1.answers[0].id },
              "1" => { content: "The Latin Language", id: q1.answers[1].id },
            }
          },

          "1" => {
            content: "Which language is spoken in America?",
            id: q2.id,
            _destroy: "1",

            answers_attributes: {
              "0" => { content: "The English Language", id: q2.answers[0].id },
              "1" => { content: "The American Language", id: q2.answers[1].id },
            }
          }
        }
      } }
    end

    survey.reload
    assert_equal 1, survey.questions.size
    assert_equal "Native languages", survey.name

    assert_redirected_to survey_path(survey)
    assert_match /was successfully updated/, flash[:notice]
  end

  test "should destroy dynamically removed answer from question" do
    survey = Survey.create!(name: "Oral languages")
    q1 = survey.questions.create!(content: "Which language is spoken in England?")
    q2 = survey.questions.create!(content: "Which language is spoken in America?")
    q1.answers.create!(content: "English")
    q1.answers.create!(content: "Latin")
    q1.answers.create!(content: "French")
    q2.answers.create!(content: "English")
    q2.answers.create!(content: "American")
    q2.answers.create!(content: "Italian")

    assert_difference('Answer.count', -2) do
      patch :update, params: { id: survey, survey: {
        name: "Native languages",

        questions_attributes: {
          "0" => {
            content: "Which language is spoken in England?",
            id: q1.id,

            answers_attributes: {
              "0" => { content: "The English Language", id: q1.answers[0].id },
              "1" => { content: "The Latin Language", id: q1.answers[1].id },
              "2" => { content: "The French Language", id: q1.answers[2].id, _destroy: "1" }
            }
          },

          "1" => {
            content: "Which language is spoken in America?",
            id: q2.id,

            answers_attributes: {
              "0" => { content: "The English Language", id: q2.answers[0].id },
              "1" => { content: "The American Language", id: q2.answers[1].id },
              "2" => { content: "The Italian Language", id: q2.answers[2].id, _destroy: "1" }
            }
          }
        }
      } }
    end

    survey.reload
    assert_equal 2, survey.questions.size
    assert_equal 2, survey.questions[0].answers.size
    assert_equal 2, survey.questions[1].answers.size

    assert_redirected_to survey_path(survey)
    assert_match /was successfully updated/, flash[:notice]
  end

  test "should destroy survey" do
    assert_difference('Survey.count', -1) do
      delete :destroy, params: { id: @survey }
    end

    assert_redirected_to surveys_path
  end
end
