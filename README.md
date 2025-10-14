![dread hunger game banner with title](./banner.jpg)

> [!IMPORTANT]
> As of 2024-01-01, **dread hunger is no longer supported by the developer and cannot be purchased from steam**.
> This means you must already own the game on steam or otherwise have access to the files in order to be able to build this image.

A [docker](https://docs.docker.com/get-started/) image for running a dedicated server for the game [Dread Hunger](https://store.steampowered.com/app/1418630/Dread_Hunger/).

## Usage

### Building and Running

To build the docker image for this server and run it locally:

1. [Install docker](https://docs.docker.com/get-started/introduction/get-docker-desktop/) if you haven't already.
2. Clone this repository: `git clone https://github.com/Laura7089/dread-hunger-docker.git`.
3. Copy (or otherwise link) the `LinuxServer` directory from your game installation[^1] into the cloned repository.
4. Build the image: `docker build -t dread-hunger .` (don't forget that last `.`!).
  This may need `sudo`.
5. Run the server: `docker run --rm -p 7777:7777/udp dread-hunger`[^2].
  This may also need `sudo`.

> [!NOTE]
> For players to connect over the internet, you must have some way for other players to see your server.
> How to do this is out of the scope of this README, but usually involves port forwarding, a peer-to-peer VPN or using a dedicated server machine.

### Connecting

To connect to the server from the game:

1. Run the server [as above](#building-and-running).
2. Open the game.
3. Open the map table, and create a lobby. <!-- TODO: does this change any settings on the server??? -->
4. Assemble your players in the lobby. <!-- TODO: how do players do this? -->
5. When you're ready, light the boiler and sail the ship out of the harbour as normal.
6. You will be presented with a prompt for an IP address.
  Enter the IP address for the machine that is hosting your server (see above).
  If you've [changed the port](#port), enter your custom port instead of the default value.
7. You and your players should connect. Enjoy!

## Configuration

### Map and Game Mode

The server is configured using [docker environment variables](https://docs.docker.com/get-started/docker-concepts/running-containers/overriding-container-defaults/#setting-environment-variables) which map onto the config as defined in the [server announcement post](https://steamcommunity.com/app/1418630/discussions/0/4035853814702993611/).
They are:

Docker Variable Name | Game Config Name | Range | Default Value
---|---|---|---
`MAP` | N/A | One of `Approach_Persistent`, `Departure_Persistent` or `Expanse_Persistent` | `Approach_Persistent`
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
docker run --rm -p 7777:7777/udp -e MAX_PLAYERS=3 -e DAYS_BEFORE_BLIZZARD=3 dread-hunger
```

### Port

If you wish to change the port the server listens on, you should do that with the [docker ports system](https://docs.docker.com/get-started/docker-concepts/running-containers/publishing-ports/):

```bash
docker run --rm -p 7777:7777/udp dread-hunger # run with the default port of 7777
docker run --rm -p 1234:7777/udp dread-hunger # run on port 1234
```

> [!WARNING]
> You should always remap the port to `7777` inside the container (on the right hand side of the `:`), and always include `/udp` otherwise you **will not be able to connect**.

## Licensing

The contents of this repo (except the banner image) are licensed under the GNU Affero General Public License.
Dread Hunger is the property of Digital Confectioners; no credit is taken for the software in this image.

[^1]: Unfortunately, because the Dread Hunger Team chose to distribute the server files using a client update rather than adding them as a separate
  app to steam, this image cannot automate downloading the server files with `steamcmd` and so a copy of the client or at least the server files within is required.
  If you know this is incorrect, please open an issue.
[^2]: The game server is stateless so the `--rm` flag is safe and keeps your container history clear.
