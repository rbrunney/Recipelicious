import com.rabbitmq.client.*;

import java.io.ByteArrayInputStream;
import java.io.ObjectInputStream;
import java.util.Arrays;
import java.util.HashMap;

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
                    HashMap<String, String> message = new HashMap<>();
                    String subject = "";
                    String emailBody = "";

                    try {
                        System.out.println(Arrays.toString(body));
                        ByteArrayInputStream bais = new ByteArrayInputStream(body);
                        ObjectInputStream ois = new ObjectInputStream(bais);

                        message = (HashMap<String, String>) ois.readObject();

                        bais.close();
                        ois.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    System.out.println(message.toString());
                }
            };
            channel.basicConsume("usercreation", true, consumer);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
