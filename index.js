// Install: npm install express discord.js body-parser cors
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Client, GatewayIntentBits } = require('discord.js');

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const DISCORD_BOT_TOKEN = 'YOUR_BOT_TOKEN';
const GUILD_ID = 'YOUR_SERVER_ID';

const client = new Client({ intents: [GatewayIntentBits.Guilds] });

client.once('ready', () => {
  console.log('Discord bot is ready!');
});

client.login(DISCORD_BOT_TOKEN);

app.post('/create-channel', async (req, res) => {
  const channelName = req.body.channel_name;
  try {
    const guild = await client.guilds.fetch(GUILD_ID);
    await guild.channels.create({
      name: channelName,
      type: 0, // 0 = text channel
    });
    res.status(200).send('Channel created');
  } catch (err) {
    res.status(500).send('Error creating channel');
  }
});

app.listen(3000, () => {
  console.log('Backend running on port 3000');
});
