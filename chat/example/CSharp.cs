socket = IO.Socket("http://funstream.tv:3811", new IO.Options { Transports = ImmutableList.Create("websocket") });

socket.On(Socket.EVENT_CONNECT, (a) =>
{
    socket.Emit("/chat/login", (b) => { }, new JObject {["token"] = token });
    socket.Emit("/chat/join", (b) => {}, "{ \"channel\": \"stream/" + streamerID + "\"}");
});

socket.On(Socket.EVENT_CONNECT_ERROR, (b) => {});
