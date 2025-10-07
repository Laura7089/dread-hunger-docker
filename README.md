![dread hunger game banner with title](./banner.jpg)

---

> [!IMPORTANT]
> As of 2024-01-01, **dread hunger is no longer supported by the developer and cannot be purchased from steam**.
> This means you must already own the game on steam or otherwise have access to the files in order to be able to build this image.

A docker image for running a dedicated server for the game [Dread Hunger](https://store.steampowered.com/app/1418630/Dread_Hunger/) on linux.

## Usage

### Building and Running

To build the docker image for this server and run it locally:

1. Clone this repository: `git clone https://github.com/Laura7089/dread-hunger-docker.git`.
2. Copy (or otherwise link) the `LinuxServer` directory from your game installation[^1] into the cloned repository.
3. Build the image: `docker build -t dread-hunger .` (this may need `sudo`).
4. Run the server: `docker run --rm -d -p 7777:7777/udp dread-hunger` (this may also need `sudo`).

To do this usefully, you **must** have some way for other players to see your server.
How to do this is out of the scope of this guide, but usually involves either port forwarding or using a dedicated server machine.

### Connecting

1. Open the game.
<!-- TODO: does this change any settings on the server??? -->
2. Open the map table, and create a lobby. 
<!-- TODO: how do players do this? -->
3. Assemble your players.
4. When you're ready, light the boiler and sail the ship out of the harbour as normal.
5. You will be presented with a prompt for an IP address.
  Enter the IP address for the machine that is hosting your server (see above).
  If you've changed the port with the `-p` parameter to docker, change the port from the default too.
6. You and your players should connect. Enjoy!

### Map and Game Mode Configuration

The server is configured using docker environment variables which map onto the config as defined in the [server announcement post](https://steamcommunity.com/app/1418630/discussions/0/4035853814702993611/).
They are:

Docker Variable Name | Game Config Name | Range | Default Value
---|---|---|---
`MAX_PLAYERS` | `maxplayers` | 1-8 | 8
`DAYS_BEFORE_BLIZZARD` | `daysbeforeblizzard` | 2-7 | 3
`DAY_MINUTES` | `dayminutes` | 5-16 | 9
`PREDATOR_DAMAGE` | `predatordamage` | 0.25-3 | 1
`COLD_INTENSITY` | `coldintensity` | 0.25-3 | 1
`HUNGER_RATE` | `hungerrate` | 0.25-3 | 1
`COAL_BURN_RATE` | `coalburnrate` | 0.1-2 | 1
`THRALLS` | `thralls` | 0-8 | 2

You should pass these when you're running the game server with the `-e` command line flag, for example:

```bash
docker run -d --rm -p 7777:7777/udp -e MAX_PLAYERS=3 -e DAYS_BEFORE_BLIZZARD=3 dread-hunger
```

## Licensing

The contents of this repo (except the banner image) are licensed under the GNU Affero General Public License.
Dread Hunger is the property of Digital Confectioners; no credit is taken for the software in this image.

[^1]: Unfortunately, because the Dread Hunger Team chose to distribute the server files using a client update rather than adding them as a separate
  app to steam, this image cannot automate downloading the server files with `steamcmd` and so a copy of the client or the server files within are required..
  If this is incorrect, please open an issue.
