require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(username: "user100", admin: false, email: "qat100@gmail.com", password: "123456")
    Article.create(title: 'tester', description: "Hello world100", user_id: @user.id)
    login_as @user
    @comment = Comment.create!(user_id: @user.id, body: "I hate this post", commentable_id: Article.last.id, commentable_type: "Article")
    Article.create(title: 'tester2', description: "Hello world100", user_id: @user.id)
  end



  test "should create comment" do
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { user_id: @user.id, body: "I hate this post", commentable_id: Article.last.id, commentable_type: "Article" } }
    end

    assert_redirected_to articles_url
  end
 
  # test "should get index" do
  #   get comments_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_comment_url
  #   assert_response :success
  # end

  # test "should show comment" do
  #   get comment_url(@comment)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_comment_url(@comment)
  #   assert_response :success
  # end

  # test "should update comment" do
  #   patch comment_url(@comment), params: { comment: {  } }
  #   assert_redirected_to comment_url(@comment)
  # end

  # test "should destroy comment" do
  #   assert_difference('Comment.count', -1) do
  #     delete comment_url(@comment)
  #   end

  #   assert_redirected_to comments_url
  # end
end
