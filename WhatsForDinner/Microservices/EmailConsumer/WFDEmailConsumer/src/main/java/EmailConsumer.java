import com.rabbitmq.client.*;
import email.SendMail;
import org.json.JSONObject;

import java.nio.charset.StandardCharsets;

public class EmailConsumer {
    public static void main(String[] args) {
        try {
            ConnectionFactory factory = new ConnectionFactory();
            factory.setHost(System.getenv("RABBITMQ_HOST"));
            factory.setPort(Integer.parseInt(System.getenv("RABBITMQ_PORT")));
            factory.setUsername(System.getenv("RABBITMQ_USERNAME"));
            factory.setPassword(System.getenv("RABBITMQ_PASSWORD"));
            Connection connection = factory.newConnection();
            Channel channel = connection.createChannel();

            channel.queueDeclare("usercreation", true, false, false, null);

            DefaultConsumer consumer = new DefaultConsumer(channel) {
                @Override
                public void handleDelivery(String consumerTag, Envelope envelope, AMQP.BasicProperties properties, byte[] body) {
                    JSONObject message = new JSONObject();

                    try {
                        String rabbitmqMessage = new String(body, StandardCharsets.UTF_8);
                        message = new JSONObject(rabbitmqMessage);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    switch (message.getString("type")) {
                        case "accountCreation":
                            new SendMail(message.getString("email"), "Account Created",
                                    "Welcome to 'Whats for dinner?'\n" +
                                            "Username: " + message.getString("username") + "\n" +
                                            "Email: " + message.getString("email") + "\n" +
                                            "Have fun and enjoy browsing all sorts of meals");
                            break;
                        case "forgotPassword":
                            new SendMail(message.getString("email"), "Forgot Password", "Here is your code to reset password: " + message.getInt("authCode"));
                            break;
                    }


                }
            };
            channel.basicConsume("usercreation", true, consumer);

            System.out.println("Email has been sent successfully :)");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
