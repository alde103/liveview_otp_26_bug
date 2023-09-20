defmodule LiveviewOtp26BugWeb.BugLive do
  use LiveviewOtp26BugWeb, :live_view
  require Logger

  @impl true
  def mount(_params, _seesions, socket) do
    {:ok,
     assign(socket,
       query: nil,
       stage_changed: false,
       username: "",
       password: "",
       r_password: "",
       flags: default_flags()
     )}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="content" style="justify-items: normal;">
      <div class="LayoutGrid" style="grid-template-columns: repeat(1, 1fr)">
        <div>
          <div class="card-edge">
            <div class="card-header">
              <h2 class="title title--small">Sign up</h2>
            </div>
            <br>
            <section class="row">
              <article class="column">
                <p>Username:</p>
                <form phx-submit="username_s">
                  <input type="text" name="username" value={@query} list="matches" placeholder={@username}>
                </form>

                <p>Password:</p>
                <form phx-submit="password_s">
                  <input type="password" name="password" value={@query} list="matches" placeholder="*****">
                </form>

                <p>Password (confirm):</p>
                <form phx-submit="r_password_s">
                  <input type="password" name="r_password" value={@query} list="matches" placeholder="*****">
                </form>
              </article>
            </section>

            <div class="card-footer">
              <section class="row">
                <article class="column">
                <%= if @flags.username_error do %><p><font color="red">* No spaces allowed! (Username)</font></p><%end%>
                <%= if @flags.password_error do %><p><font color="red">* No spaces allowed! (Password)</font></p><%end%>
                <%= if @flags.r_password_error do %><p><font color="red">* No spaces allowed! (Confirmed password)</font></p><%end%>
                <%= if @password != @r_password do %><p><font color="red">* Confirmed password doesn't match!</font></p><%end%>
                </article>
              </section>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("username_s", %{"username" => username}, socket) do
    new_assigns =
      with  false <- String.contains?(username, " ") do
        Logger.info("(#{__MODULE__}) New username: #{username}")

        socket.assigns
        |> put_in([:username], username)
        |> put_in([:is_default?], false)
        |> put_in([:flags, :username_error], false)
      else
        _ ->
          Logger.debug("(#{__MODULE__}) Error username: #{username}")
          socket.assigns
          |> put_in([:flags, :username_error], true)
      end
      |> Map.drop([:flash])

    {:noreply, assign(socket, new_assigns)}
  end

  def handle_event("password_s", %{"password" => password}, socket) do
    new_assigns =
      with  false <- String.contains?(password, " ") do
        Logger.info("(#{__MODULE__}) New password: *****")

        socket.assigns
        |> put_in([:password], password)
        |> put_in([:is_default?], false)
        |> put_in([:flags, :password_error], false)
      else
        _ ->
          Logger.debug("(#{__MODULE__}) Error password")
          socket.assigns
          |> put_in([:flags, :password_error], true)
      end
      |> Map.drop([:flash])

    {:noreply, assign(socket, new_assigns)}
  end

  def handle_event("r_password_s", %{"r_password" => r_password}, socket) do
    new_assigns =
      with  false <- String.contains?(r_password, " ") do
        Logger.info("(#{__MODULE__}) New r_password: *****")

        socket.assigns
        |> put_in([:r_password], r_password)
        |> put_in([:flags, :r_password_error], false)
      else
        _ ->
          Logger.debug("(#{__MODULE__}) Error r_password")
          socket.assigns
          |> put_in([:flags, :r_password_error], true)
      end
      |> Map.drop([:flash])

    {:noreply, assign(socket, new_assigns)}
  end

  def default_flags() do
    %{
      username_error: false,
      password_error: false,
      r_password_error: false
    }
  end
end
