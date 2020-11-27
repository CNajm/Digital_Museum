BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Room" (
	"RID"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"theme"	TEXT,
	PRIMARY KEY("RID")
);
CREATE TABLE IF NOT EXISTS "Creator" (
	"CID"	INTEGER,
	"name"	INTEGER NOT NULL UNIQUE,
	"born"	TEXT NOT NULL,
	"died"	TEXT,
	PRIMARY KEY("CID")
);
CREATE TABLE IF NOT EXISTS "ArtLocations" (
	"AID"	INTEGER,
	"CONID"	INTEGER,
	FOREIGN KEY("CONID") REFERENCES "Country"("CONID"),
	FOREIGN KEY("AID") REFERENCES "Art"("AID")
);
CREATE TABLE IF NOT EXISTS "Country" (
	"CONID"	INTEGER,
	"conname"	TEXT NOT NULL,
	PRIMARY KEY("CONID")
);
CREATE TABLE IF NOT EXISTS "CountryMuseums" (
	"CONID"	INTEGER,
	"MID"	INTEGER NOT NULL,
	PRIMARY KEY("CONID"),
	FOREIGN KEY("CONID") REFERENCES "Country"("CONID"),
	FOREIGN KEY("MID") REFERENCES "Museum"("MID") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "Museum" (
	"MID"	INTEGER,
	"name"	TEXT NOT NULL,
	"geo"	TEXT UNIQUE,
	"country"	TEXT,
	PRIMARY KEY("MID")
);
CREATE TABLE IF NOT EXISTS "Inspirations" (
	"master"	INTEGER,
	"student"	INTEGER,
	FOREIGN KEY("student") REFERENCES "Creator"("CID") ON DELETE CASCADE,
	FOREIGN KEY("master") REFERENCES "Creator"("CID") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "Art" (
	"AID"	INTEGER,
	"time_period"	TEXT,
	"description"	TEXT,
	"name"	TEXT NOT NULL UNIQUE,
	"created_by"	INTEGER NOT NULL,
	"creation_date"	TEXT,
	"type"	TEXT,
	"style"	TEXT,
	"medium"	TEXT,
	"material"	TEXT,
	"located"	INTEGER,
	"inroom"	INTEGER,
	"url"	TEXT,
	PRIMARY KEY("AID"),
	FOREIGN KEY("located") REFERENCES "Museum"("MID"),
	FOREIGN KEY("created_by") REFERENCES "Creator"("CID") ON DELETE SET NULL,
	FOREIGN KEY("inroom") REFERENCES "Room"("RID")
);
INSERT INTO "Room" ("RID","name","theme") VALUES (1,'Classical','Classical'),
 (2,'Neoclassical','Neoclassical'),
 (3,'Modern','Modern');
INSERT INTO "Creator" ("CID","name","born","died") VALUES (1,'Jan Matejko','June 24, 1838','November 1, 1893'),
 (2,'Jacques-Louis David','August 30, 1748','December 29, 1825'),
 (3,'Vincent van Gogh','March 30, 1853','July 29, 1890'),
 (4,'Johannes Vermeer','October 1632','December 1675'),
 (5,'Henri de Toulouse-Lautrec','November 24, 1864','September 9, 1901'),
 (6,'Banksy','July 28, 1973',NULL),
 (7,'John Singer Sargent','1856','1925'),
 (8,'Vik Muniz','1961',NULL),
 (9,'Michelangelo','March 6, 1475','February 18, 1564'),
 (10,'Pablo Picasso','October 25, 1881','April 8, 1973'),
 (11,'William Wordsworth','April 7, 1770','April 23, 1850,'),
 (12,'William Butler Yeats','June 13, 1865','January 28, 1939'),
 (13,'Percy Bysshe Shelley','August 4, 1792','July 8, 1822'),
 (14,'Lord Byron','January 22, 1788','April 19, 1824'),
 (15,'Edgar Allan Poe','January 19, 1809','October 7, 1849'),
 (16,'Auguste Rodin','November 12, 1840','November 17, 1917'),
 (17,'Trashtist','',NULL),
 (18,'A, Inspired B','',NULL),
 (19,'B, Inspired C','',NULL),
 (20,'C','',NULL);
INSERT INTO "ArtLocations" ("AID","CONID") VALUES (1,1),
 (2,2),
 (3,NULL),
 (4,3),
 (5,4);
INSERT INTO "Country" ("CONID","conname") VALUES (1,'Poland'),
 (2,'Belgium'),
 (3,'Netherlands'),
 (4,'USA');
INSERT INTO "CountryMuseums" ("CONID","MID") VALUES (1,1),
 (2,2),
 (3,4),
 (4,5);
INSERT INTO "Museum" ("MID","name","geo","country") VALUES (1,'Warsaw National Museum','52.231684104017674, 21.02483088482906','Poland'),
 (2,'Royal Museums of Fine Arts of Belgium','50.84204552793822, 4.357914427120332','Belgium'),
 (3,'Private collection',NULL,NULL),
 (4,'Mauritshuis','52.080460040464445, 4.314269111813733','Netherlands'),
 (5,'Art Institute of Chicago','41.87959947777751, -87.62370793562687','USA'),
 (6,'Metropolitan Museum of Art','40.77946529770212, -73.96324897979744','USA'),
 (7,'Galleria dell''Accademia','43.77741873575336, 11.258470738636987','Italy'),
 (8,'',NULL,NULL);
INSERT INTO "Inspirations" ("master","student") VALUES (3,2),
 (9,1),
 (9,2),
 (9,3),
 (9,4),
 (9,5),
 (9,6),
 (9,7),
 (9,8),
 (18,19),
 (19,20);
INSERT INTO "Art" ("AID","time_period","description","name","created_by","creation_date","type","style","medium","material","located","inroom","url") VALUES (0,'Early Americana','Edgar Allan Poe (1809-49) wrote ‘Alone’ when he was still very young – only 21 years of age. The poem remained unpublished until 1875, over a quarter of a century after Poe’s death. The sentiment is, indeed, something that many of us can relate to from our teenage years and youth: feeling all alone and that we are a misfit in the world around us, not just physically but emotionally alone.','Alone',15,'1829','Literature','lyric ',NULL,NULL,NULL,NULL,'https://i.imgur.com/ERLqJbu.png'),
 (1,'Renaissance','Stańczyk is a painting by Jan Matejko finished in 1862. The figure of Stańczyk has roots in the cultural trope of the fool/wisdom duality and the sad clown paradox.

The primary composition of the painting is in the contrast between the solemn jester (Stańczyk) – obviously the focus of the painting – and the lively ball going on in the background. Stańczyk is shown sitting alone in a dark room, while a ball, hosted by the royal family, is in full swing in the neighbouring hall. His appearance is unlike that one would expect in a jester – gloomy, deep in thought. His seriousness is reinforced by his accessories: his marotte lies discarded on the floor, whereas a holy medallion of the Black Madonna of Częstochowa can be seen on his torso. The wrinkled carpet at Stanczyk''s feet could have been formed by his collapsing heavily into the chair upon reading the letter, or through a nervous shifting of the feet thereafter. On the table lies a letter likely announcing that Poland has lost Smolensk (now in Russia) to the Grand Duchy of Muscovy, causing Stańczyk''s sorrow and reflection on his fatherland''s fate. The letter seems to have been discarded by some official, and only the jester realizes its significance.','Stańczyk',1,'1862','Painting','Renaissance','Oil on Canvas',NULL,1,1,'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Jan_Matejko_-_Sta%C5%84czyk_-_Google_Art_Project.jpg/800px-Jan_Matejko_-_Sta%C5%84czyk_-_Google_Art_Project.jpg'),
 (2,'Neoclassicism','The Death of Marat is a 1793 painting by Jacques-Louis David of the murdered French revolutionary leader Jean-Paul Marat. It is one of the most famous images of the French Revolution. The painting shows the radical journalist lying dead in his bath on 13 July 1793, after his murder by Charlotte Corday.

Marat (24 May 1743 – 13 July 1793) was one of the leaders of the Montagnards, the radical faction ascendant in French politics during the Reign of Terror until the Thermidorian Reaction. Charlotte Corday was a Girondin from a minor aristocratic family and a political enemy of Marat who blamed him for the September Massacre. She gained entrance to Marat''s rooms with a note promising details of a counter-revolutionary ring in Caen.

Marat suffered from a skin condition that caused him to spend much of his time in his bathtub; he would often work there. Corday fatally stabbed Marat, but she did not attempt to flee. She was later tried and executed for the murder.','The Death of Marat',2,'1793','Painting','Neoclassicism','Oil on Canvas',NULL,2,2,'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Death_of_Marat_by_David.jpg/466px-Death_of_Marat_by_David.jpg'),
 (3,'Post-Impressionism','This Van Gogh painting is among his most well-known and was drawn during the post-impressionist period.

After Van Gogh was released from asylum, he was sent to Dr. Gachet, so that he was still under some supervision. The doctor was also a fan of working artists. Some days later, Van Gogh wrote to his brother Theo that the doctor was sicker than he was and should look for someone else. However, a couple of days later, he wrote to his sister, “I have found a true friend in Dr. Gachet, something like another brother, so much do we resemble each other physically and also mentally.”

There began a beautiful friendship. Van Gogh ended up painting two versions of the Portrait of Dr. Gachet. After completing the painting, he wrote to his brother saying, “I’ve done the portrait of M. Gachet with a melancholy expression, which might well seem like a grimace to those who see it”. Today, this painting is one of the most famous and expensive paintings of all time.
','Portrait of Dr. Gachet',3,'1890','Painting','Post-Impressionism','Oil on Canvas',NULL,3,1,'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Van_Gogh_-_Bildnis_Doktor_Gachet.jpeg/800px-Van_Gogh_-_Bildnis_Doktor_Gachet.jpeg'),
 (4,'Dutch Golden Age','Girl with a Pearl Earring is an oil painting by Dutch Golden Age painter Johannes Vermeer. Going by various names over the centuries, it became known by its present title towards the end of the 20th century after the large pearl earring worn by the girl portrayed there. In 2006, the Dutch public selected it as the most beautiful painting in the Netherlands.
','Girl with a Pearl Earring',4,'1665','Painting','Tronie','Oil on Canvas',NULL,4,1,'https://upload.wikimedia.org/wikipedia/commons/d/d7/Meisje_met_de_parel.jpg'),
 (5,'Post-Impressionism','At the Moulin Rouge is an oil-on-canvas painting by French artist Henri de Toulouse-Lautrec. It was painted between 1892 and 1895. It is one of a number of works by Toulouse-Lautrec depicting the Moulin Rouge cabaret built in Paris in 1889; the others include At the Moulin Rouge, The Dance, and the poster Moulin Rouge: La Goulue. Included in the background is a self-portrait of the artist.

Born to wealth and privilege, Toulouse-Lautrec abandoned his aristocratic roots in favor of the working-class Montmartre district and its colorful nightlife. The artist appears to have been afflicted with a genetic disorder affecting growth and bone development; he walked with a cane and reached an adult height of just 4-foot-8. Taunted for his physical appearance, he self-medicated with alcohol, notably absinthe. “At the Moulin Rouge” depicts the world in which Toulouse-Lautrec felt most at ease. 
','At the Moulin Rouge',5,'1892','Painting','Post-Impressionism','Oil on Canvas',NULL,5,1,'https://upload.wikimedia.org/wikipedia/commons/2/27/Henri_de_Toulouse-Lautrec_-_At_the_Moulin_Rouge_-_Google_Art_Project.jpg'),
 (6,'Modern','In 2002, the stenciled image of a girl reaching toward a red, heart-shaped balloon appeared on a staircase leading to London’s Waterloo Bridge. Attributed to the elusive artist Banksy, several other examples popped up around London in subsequent years.

In 2018, a 2006 version of the painting was auctioned at Sotheby’s for the princely sum $1.4 million, automatically shredding itself by means of a device hidden by the artist within the frame the moment the gavel hit the block. Moments after the incident, Banksy posted an Instagram video depicting telephone staff staring in shock at the mutilated work. The act itself was a jab at the art world and to one that cared more about art valuations than the art itself.','Girl with Balloon',6,'2002','Painting','Modern','Graffiti',NULL,NULL,3,'https://upload.wikimedia.org/wikipedia/commons/0/0c/Banksy_Girl_and_Heart_Balloon_%282840632113%29.jpg'),
 (7,'Realism','Portrait of Madame X is the title of a portrait painting of a young socialite and wife of a French banker. Madame X was painted not as a commission, but at the request of Sargent. It is a study in opposition. Sargent shows a woman posing in a black satin dress with jeweled straps, a dress that reveals and hides at the same time. The portrait is characterized by the pale flesh tone of the subject contrasted against a dark colored dress and background.

Sargent had hoped the portrait would make his career. The painting, however, set off a scandal of such magnitude that Sargent exiled himself to England. What was it that had so offended Parisian high society? While the image’s overt sexuality was expected for a mythological heroine and tolerable for a prostitute moonlighting as an artist’s model, it was downright threatening when applied to a woman of their own cast.

Source: Metropolitan Museum of Art','Portrait of Madame X',7,'1884','Painting','Portrait','Oil on Canvas',NULL,6,1,'https://upload.wikimedia.org/wikipedia/commons/a/a4/Madame_X_%28Madame_Pierre_Gautreau%29%2C_John_Singer_Sargent%2C_1884_%28unfree_frame_crop%29.jpg'),
 (8,'Modern','Jardim Gramacho, a 321-acre plot of land on the northern edge of Rio de Janeiro, was the world’s largest garbage dump until it closed in 2012. Between 2007 and 2010, the Jardim became a kind of studio for Brazilian-born, New York- and Rio-based artist Muniz. The artworks created there became a series called Pictures of Garbage, which recreate iconic images from art history using trash collected from the dump.

Muniz’s work prompts a number of important questions regarding contemporary art. Ethics is a good place to start, especially regarding collaborations with “marginalized” or poorer segments of society, which has become a common practice for contemporary artists interested in socially engaged art.','Marat (Sebastião)',8,'2008','Painting','Modern','Digital Print',NULL,NULL,3,'https://i.imgur.com/ZuXOyR8.jpg'),
 (9,'Renaissance','One of the most iconic works in all of art history, Michelangelo’s David had its origins in a larger project to decorate the buttresses of Florence’s great cathedral, the Duomo, with a group of figures taken from the Old Testament. The David was one, and was actually begun in 1464 by Agostino di Duccio. Over the next two years, Agostino managed to rough out part of the huge block of marble hewn from the famous quarry in Carrara before stopping in 1466. (No one knows why.) Another artist picked up the slack, but he, too, only worked on it briefly. The marble remained untouched for the next 25 years, until Michelangelo resumed carving it in 1501. He was 26 at the time. When finished, the David weighed six tons, meaning it couldn’t be hoisted to the cathedral’s roof. Instead, it was put on display just outside to the entrance to the Palazzo Vecchio, Florence’s town hall. The figure, one of the purest distillations of the High Renaissance style, was immediately embraced by the Florentine public as a symbol of the city-state’s own resistance against the powers arrayed against it. In 1873, the David was moved to Accademia Gallery, and a replica was installed in its original location.
','David',9,'1504','Sculpture',NULL,'','Marble',7,1,'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/%27David%27_by_Michelangelo_Fir_JBU002.jpg/1200px-%27David%27_by_Michelangelo_Fir_JBU002.jpg'),
 (10,'Synthetic cubism','In 1912, Picasso created a cardboard maquette of a piece that would have an outsized impact on 20th-century art. Also in MoMA’s collection, it depicted a guitar, a subject Picasso often explored in painting and collage, and in many respects, Guitar transferred collage’s cut and paste techniques from two dimensions to three. It did the same for Cubism, as well, by assembling flat shapes to create a multifaceted form with both depth and volume. Picasso’s innovation was to eschew the conventional carving and modeling of a sculpture out of a solid mass. Instead, Guitar was fastened together like a structure. This idea would reverberate from Russian Constructivism down to Minimalism and beyond. Two years after making the Guitar in cardboard, Picasso created this version in snipped tin.','Guitar',10,'1913','Sculpture','Abstract','','Cardboard',NULL,NULL,'https://www.pablopicasso.org/images/paintings/guitar.jpg'),
 (11,'Victorian','Ozymandias is a fourteen line sonnet written in 1817 by a British Romantic poet whose name is synonymous with radical social and political change.
<br /><br />
Percy Bysshe Shelley lived a chaotic, nomadic life but managed to produce poetry and pamphlets for most of his adult years. He eventually married Mary Wollstonecraft Godwin, the daughter of philosopher William Godwin, and eloped with her to Europe, living in a circle of artistic friends and lovers which included for a time Lord Byron.
<br /><br />
It was during this time that Shelley died at the age of 29 when his boat sank in a storm in the Gulf of Spezia, Italy. Atheist, pacifist and vegetarian, he was mourned by his close friends but back in England lacked support because he was seen as an agitator.
<br /><br />
Ozymandias is a political poem at heart, written at a time when Napoleon''s domination of Europe was coming to an end and another empire, that of Great Britain''s, was about to take over.
<br /><br />
Shelley''s poem encapsulates metaphorically the outcome of such tyrannical wielding of power - no leader, King, despot, dictator or ruler can overcome time. Overall, this sonnet paints a picture of an egotistical character who thought himself without rival but who was cruel to his people.
<br /><br />
Source: Owlcation - Andrew Spacey','Ozymandias',13,'1817 ','Literature','Sonnet',NULL,NULL,NULL,NULL,'https://i.imgur.com/au12h59.png'),
 (12,'Early Americana','This poem was written by Edgar Allan Poe and was first published in 1849 in a magazine, The Flag of Our Union. The poem is famous for the way it presents human’s predicament of transient life and dreams. The poem comprises the speaker’s profound feelings, anxious state of mind and existential crisis of life and dreams.

Edgar Allan Poe''s short poem A Dream Within A Dream questions the nature of reality and human existence. Fundamental perceptions might not be what they seem to be. Is life nothing but a series of unreal events that the mind invents within the unreal environment created by God?

Time passes and there is little we can do to arrest it, keep hold of it. Human emotions, thoughts and consciousness cannot affect this notion of life as a series of subconsciously driven experiences.

A human dream within a divine dream?

Poe is saying that some of us could be accused of living life as in a dream, that is, with hardly a grip on reality, but nevertheless, some of those dreamers may be visionaries. Hope springs eternal, hope goes, no matter how we live

Source: Owlcation - Andrew Spacey
','A Dream',15,'1849','Literature','Iambic Trimeter',NULL,NULL,NULL,NULL,'https://i.imgur.com/AXc6XfY.png'),
 (14,'Victorian','The poem celebrates the enchanting beauty of the women, and the poet is captivated by it. Lord Byron gives a critical message to the readers that perfect beauty is the combination of outward looks as well as inner beauty. According to him, the lady is blessed with attractive looks and also possesses a physical and spiritual harmony. Her innocent and pure thoughts further illuminate her beauty.  It is through her graceful walk and pleasant face, Byron gives a clue of her innocent soul. The expression of beauty remains at the core of the poem.','She Walks in Beauty',14,'1814 ','Literature','Iambic Tetrameter',NULL,NULL,NULL,NULL,'https://i.imgur.com/OMGj0IP.png'),
 (15,'Victorian','William Butler Yeats wrote “The Lake Isle of Innisfree,” one of his most famous and widely-anthologized works, in 1888. The poem gets its title from a very small, uninhabited island that sits in Lough Gill, a lake in Yeats’s home county of Sligo, Ireland. The speaker of this pastoral poem longs to build a simple life on Innisfree, finding peace through communion with nature. However, it becomes clear that ties to city life prevent the speaker from realizing this dream. The young poet’s fixation on questions of spirituality and Irish identity is felt in this poem, which also contains the sort of archaic language that he would later abandon and decry. Following an ABAB rhyme scheme and loosely iambic meter, the poem’s seemingly neat, concise structure belies its complex networks of rhythm and sound, which are responsible for much of its visceral impact and enduring popularity.

','The Lake Isle Of Innisfree',12,'1890','Literature','Iambic Hexameter',NULL,NULL,NULL,NULL,'https://i.imgur.com/uQVSPEy.png'),
 (16,'World War I','"The Second Coming" is one of W.B. Yeats''s most famous poems. Written in 1919 soon after the end of World War I, it describes a deeply mysterious and powerful alternative to the Christian idea of the Second Coming—Jesus''s prophesied return to the Earth as a savior announcing the Kingdom of Heaven. The poem''s first stanza describes a world of chaos, confusion, and pain. The second, longer stanza imagines the speaker receiving a vision of the future, but this vision replaces Jesus''s heroic return with what seems to be the arrival of a grotesque beast. With its distinct imagery and vivid description of society''s collapse, "The Second Coming" is also one of Yeats''s most quoted poems.

Yeats began writing the poem in January 1919, in the wake of the First World War, the Russian Revolution, and political turmoil in his native Ireland. But the first stanza captures more than just political unrest and violence. Its anxiety concerns the social ills of modernity: the rupture of traditional family and societal structures; the loss of collective religious faith, and with it, the collective sense of purpose; the feeling that the old rules no longer apply and there’s nothing to replace them. It’s the same form of despair we see in, say, Ivan Karamazov.

Of course, twentieth-century history did turn more horrific after 1919, as the poem forebodes. The narrator suggests something like the Christian notion of a “second coming” is about to occur, but rather than earthly peace, it will bring terror. As for the slouching beast, the best explanation is that it’s not a particular political regime, or even fascism itself, but a broader historical force, comprising the technological, the ideological, and the political. A century later, we can see the beast in the atomic bomb, the Holocaust, the regimes of Stalin and Mao, and all manner of systematized atrocity.','The Second Coming',12,'1919','Literature','Blank Verse',NULL,NULL,NULL,NULL,'https://i.imgur.com/ZUad2KN.png'),
 (17,'English Romanticism','A Complaint speaks about a grave change that the poet has undergone in his life – someone in his life, a friend, a lover – has gone away from him, or has changed his ideals, and remains no longer the person that the poem knows, the person that the poet cared for and loved; he has become, instead, a stranger that he does not know, and this leads the poet to lamenting the fact that his heart has led him into misery; that his emotions for this person whom he had once held so closely have now become a problematic, trying thing for him.','A Complaint',11,'1807','Literature','Iambic Pentameter',NULL,NULL,NULL,NULL,'https://i.imgur.com/wqrvpC1.png'),
 (18,'Renaissance','La Pietà (The Pity) is a famous work by Renaissance artist Michelangelo. It depicts Jesus lying in Mary’s lap after the Crucifixion and combines elements of Renaissance beauty standards with more natural values. The statue has been on display in St. Peter’s Basilica in Vatican City since its creation, and originally marked the tomb of a cardinal. The statue is interesting because it doesn’t show any real signs of the Crucifixion, and Jesus appears serene rather than in pain. This was apparently because Michelangelo wanted to show the communion between God and man through Jesus, rather than suffering and death.','Pieta',9,'1499','Sculpture',NULL,NULL,'Marble',NULL,NULL,'https://www.artblr.com/upload/userfiles/images/Michelangelo-pieta.jpg'),
 (19,'Impressionism ','The Thinker, French Le Penseur, a sculpture of a pensive nude male by French artist Auguste Rodin, one of his most well-known works. Many marble and bronze editions in several sizes were executed in Rodin’s lifetime and after, but the most famous version is the 6-foot (1.8-metre) bronze statue (commonly called a monumental) cast in 1904 that sits in the gardens of the Rodin Museum in Paris. The large muscular figure has captivated audiences for decades in his moment of concentrated introspection.

The Thinker was originally called The Poet and was conceived as part of The Gates of Hell, initially a commission (1880) for a pair of bronze doors to a planned museum of decorative arts in Paris. Rodin chose for his subject Dante’s Inferno from The Divine Comedy (c. 1308–21) and modeled a series of small clay figures that represented some of the poem’s tormented characters. The museum, however, was never constructed, and The Gates were never cast during Rodin’s lifetime. Some suggestion of his vision can be found in the original plaster exhibited at the Musée d’Orsay and in the doors that were made posthumously. In these examples, a 27.5-inch (70-cm) Poet appears on the tympanum above the doors. The nude form is seated on a rock, his back hunched forward, brows furrowed, chin resting on his relaxed hand, and mouth thrust into his knuckles. Still and pensive, he observes the twisting figures of those suffering in the circles of Hell below. Some scholars suggest that the Poet was originally meant to represent Dante, but the muscular and bulky form contrasts with typical sculptures that depict the poet as slender and lithe.','The Thinker',16,'1904','Sculpture',NULL,NULL,'Marble and Bronze',NULL,NULL,'https://i.imgur.com/5t5cnh8.jpg'),
 (69,'Garbageocene','don''t let this description distract you from the fact that I should be deleted','DeleteMe',9,'Tomorrow','Painting','Trashism','Trash on Pixels',NULL,NULL,NULL,'https://i.pinimg.com/originals/0d/f0/9a/0df09ae746b552aef2b5c22f778cb739.jpg');
COMMIT;
