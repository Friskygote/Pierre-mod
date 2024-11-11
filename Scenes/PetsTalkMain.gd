extends SceneBase

func _init():
	sceneID = "PetsTalkScene"

func _run():

	if(state == ""):
		setLocationName("Issix's Corner")
		saynn("In front of you - three slaves belonging to Issix.")
		addCharacter("azazel")
		addCharacter("lamia")
		addCharacter("hiisi")
		addButton("Azazel", "Approach Azazel", "azazelmain")
		addButton("Hiisi", "Approach Hiisi", "hiisimain")
		addButton("Lamia", "Approach Lamia", "lamiamain")
		addButton("Leave", "Be on your way", "endthescene")
		
	if(state == "azazelmain"):
		playAnimation(StageScene.Duo, "kneel", {pc="azazel", npc="pc", bodyState={naked=false, hard=false}})
		clearCharacter()
		addCharacter("azazel")
		addButton("Talk", "Talk to Azazel", "azazeltalk")
		addButton("Appearance", "Look at Azazel", "azazelappearance")
		if(GM.pc.getInventory().hasItemID("CatnipPlant")):
			saynn("Before you even have the time to approach Azazel, you see his head hovering over his body, his little nose working very hard to track down the source of the curious smell. He looks around with interest, until he sees you approaching.\nHe observes you with interest as you come close.")
			saynn("[say=azazel]Meow! You really smell of a catnip, do you have catnip? Do you??[/say]")
			saynn("{azazel.name} becomes really excited, as exemplified by his tail stretching high as if it was a broom stick. His body constantly sways.")
			addButton("Give Catnip", "Give Azazel the catnip", "catnip")
		else:
			if getModuleFlag("IssixModule", "PC_Enslavement_Role", 0) == 0:
				saynn("You approach Azazel, he recognizes sudden attention given to him, he goes on his fours doing some kitty back streching before kneeling towards you expectandly. You notice he took a quick peek at his master beforehand.")
			else:
				pass  # TODO
		addButton("Back", "Take a step back", "")
		
	if state == "hiisimain":
		if getModuleFlag("IssixModule", "PC_Enslavement_Role", 0) == 0:
			saynn("You approach Lamia")
			
		else:
			addButton("Talk", "Talk to Lamia", "hiisitalk")
			addButton("Appearance", "Look at Lamia", "hiisiappearance")
		
	if state == "hiisitalk":
		var HiisiRPS = getModuleFlag("IssixModule", "Hissi_RPS_data")
		if HiisiRPS != null:
			if HiisiRPS["chosen_reward"] == 3 and HiisiRPS["reward_acquired"] == false:
				addButton("Drink", "Ask Hiisi about energy drink that you've won through the game of Rock Paper Scissors", "hiisienergy")
				
				
		# TODO
	if state == "hiisienergy":
		var HiisiRPS = getModuleFlag("IssixModule", "Hissi_RPS_data")
		HiisiRPS["reward_acquired"] = true
		setModuleFlag("IssixModule", "Hissi_RPS_data", HiisiRPS)
		saynn("[say=hiisi]Sure, I got it, here you go.[/say]")
		saynn("He passes energy drink can to you. Thanks for brightening my mood that day.")
		saynn("You received 1 Energy Drink.")
		addButton("Back", "Take a step back", "hiisitalk")
			
	if(state == "lamiamain"):
		if getModuleFlag("IssixModule", "PC_Enslavement_Role", 0) == 0:
			saynn("You approach Lamia")
			
		else:
			pass  # TODO
		addButton("Talk", "Talk to Lamia", "lamiatalk")
		addButton("Appearance", "Look at Lamia", "lamiaappearance")
		saynn("")
			
	if(state == "catnip"):
		saynn("You take the catnip and slowly reach your paw with the plant to the feline. Halfway there feline snatches the catnip from you paw and throws it in the air. His paws go above and he plays airborne valley...catnip with it? Eventually he misses with his paw and catnip falls on his muzzle, he freezes for a moment as if paralyzed, the pupils in his eyes become large.")
		saynn("[say=pc]Umm, Azazel, are you okey?[/say]")
		sayn("He turns his face towards you again, enlarged pupils still in his eyes, surprised face expression staring at you.")
		saynn("After a moment his pupils go back to normal, and his face expression turns content.")
		saynn("[say=azazel]Meow! I mean... Yes, sorry, I got... A bit carried away.[/say]")
		saynn("He becomes a little embarassed. Looks down at the catnip plant on his blanket. Picks it up with his paw and consumes it.")
		saynn("[say=azazel]Twank yuu {pc.name}. It was really nice![/say]")
		processTime(1 * 60)
		addButton("Back", "End catnip therapy session", "azazelmain")
		#setState("azazelmain")
		
	if(state == "azazeltalk"):
		GM.main.setModuleFlag("IssixModule", "Azazel_Catnip_talked", true)
		var affection = getModuleFlag("IssixModule", "Azazel_Affection_given")
		addButton("Prison", "Ask how did he end up in prison?", "azazelprison")
		addButton("Hobby", "Ask what hobbies does he have", "azazelhobby")
		if affection > 2:
			addButton("Issix", "Ask what he thinks of his master?", "azazelmaster")
		else:
			addDisabledButton("Issix", "You don't have good enough relationship with Azazel to ask about his master")
		if affection > 5:
			addButton("Breeder", "Ask what he thinks of his position as a breeding bitch?", "azazelbreeding")
		else:
			addDisabledButton("Breeder", "You don't have good enough relationship with Azazel to ask about his position as breeding bitch")
		if affection > 10:
			addButton("Fetishes", "He mentioned his fetishes, perhaps he could elaborate?", "azazelfetishes")
		else:
			addDisabledButton("Breeder", "You don't have good enough relationship with Azazel to ask about his fetishes")
		if affection > 18:
			addButton("Pussy", "Azazel has a pussy and yet he is rather masculine", "azazelintersex")
		else:
			addDisabledButton("Pussy", "You don't have good enough relationship with Azazel to ask about his genitalia")
		#addButton("Hero", "")
		if(GM.pc.getInventory().hasItemID("CatnipPlant")):
			pass
		else:
			pass
		addButton("Back", "Do something else", "azazelmain")
		
	if(state == "azazelappearance"):
		if(OPTIONS.isContentEnabled(ContentType.Watersports)):
			saynn("When approaching there are two distinct smells coming from Azazel - his own pheromones advertising his fertility to everyone around, as well another strong smell of his master. Azazel has been marked, in more ways than one.")
		else:
			saynn("When approaching there is one distinct smell coming from Azazel - his own pheromones advertising his fertility to everyone around.")
		saynn("You take a closer look at {azazel.name}. He is a very thin and fairly short feline, judging from him sitting he is around " + Util.cmToString(150) + " tall, with no visible muscles, likely not very strong. Overall his body is still mostly masculine, though here and there there are feminine features like his face or shoulders.\nHis fur is in majority dark grey, though his belly and face are of ligher shade of gray. A small set of horns protrudes from his head. On his backside there is a medium sized feline tail.\n\nOne significant detail is that he does not possess a penis, in its place there is a {azazel.pussyStretch} vagina, above which you can see a womb tattoo seemingly glowing a bit in shade of red.")
		saynn("On his lower back words ”PROPERTY OF ISSIX” branded onto the skin - a mark of his master.")
		addButton("Back", "Do something else", "azazelmain")

	if state == "azazelprison":
		saynn("[say=pc]Tell me Azazel, what had happened that you've ended up in this prison? You are a Lilac, so I assume it had something to do with sex.[/say]")
		saynn("[say=azazel]It's true... There is a group on my home planet, they claim they want to cleanse the society of trash, and by trash they of course mean everyone they deem too radical for their own liking.[/say]")
		saynn("Azazel looks down, this conversation seems to bring back bad memories.")
		saynn("[say=azazel]One of the group's members wanted to meet me one day, they wanted to... Procure my services. Turns out it was all just a plot, they got close to me and I didn't really see anything wrong with that, I shared a lot of personal details with them - my life, financial situation even fetishes, they felt really honest and... Caring. Eventually they tore down their mask and said they have all kind of dirt on me. That's where the hell broke loose, their group were on my back for a while, stalking, harassing me. Eventually one of my clients infected me with something transmitted sexually, I think it was the group who sent me that client and...[/say]")
		saynn("Azazel's voice starts to break down.")
		saynn("[say=azazel]They reported me, I had my license taken and now I'm in here.[/say]")
		saynn("You both sit in awkward silence while Azazel recovers.")
		saynn("[say=azazel]I will never understand groups as that one. There are more of those all over the galaxy, I know that. They ruin the lives of so many of us.. Workers. What have we done to wrong them? Nothing, we just sell our time and bodies to give others and ourselves some temporary pleasures in this grim world we live in.[/say]")
		saynn("He sighs, it seems to have calmed him down")
		saynn("[say=azazel]When I first arrived here I were so lost. Still very confused by this series of events, felt betrayed, hurt. Eventually I've met Master, they saw something in me and theey guided me through my trauma. I were really happy to become his pet. And honestly? It's not so bad, I have food, shelter and Master who takes care of me. And my heats.[/say]")
		saynn("He says the last one, showing you his tongue at you in a grin")
		saynn("[say=azazel]So... Yeah... That's how I ended up here. Not a happy story, but I doubt anyone's is. Ironically, I think I'm better here, and I can still engage in sex without any stupid license.[/say]")
		addButton("Back", "Do something else", "azazelmain")

	if state == "azazelhobby":
		saynn("[say=pc]What hobbies do you have Azazel?[/say]")
		saynn("[say=azazel]Oh, hobbies! I had some of them before I got sent to prison. Not so many anymore.[/say]")
		saynn("His head lowers and his tail curls around him, you figure he misses something from the past.")
		saynn("[say=azazel]Can you believe I've been a mediator between some communities? You know, like a person to be a bridge between two groups of interest? I've been told I were really good with talking and resolving conflicts, so after few time I've been pushed into uncomfortable situation of mediating between friends or even groups of people I found I really liked that.[/say]")
		saynn("A ever so slightly visible smile creeps onto his face.")
		saynn("[say=azazel]Eventually I've found a need for a volunteer mediator on my planet. Here a citizen group wanted something from the government and needed someone to mediate, here a local community wanted a free entry to an area managed by other community and they had a year long argument about it, that I were able to resolve in just 5 hours. I felt really needed. Granted, what little credits I got out of those meditations didn't really cover costs of living, so my main source of income was selling my body. But helping communities around truthfully gave me purpose, and seeing happy people after successful negotiations was so so cool![/say]")
		saynn("He recalls more cases where he mediated. His voice when he tells those is filled with hope and happiness. He remembers many details about people he had helped - they've made an impact on him.")
		saynn("[say=pc]Have you considered continuing your hobby here?[/say]")
		saynn("[say=azazel]I don't know... Master asked me the same question. Prison is a very... Different place. I don't think it would work, besides, what kind of thing I'd mediate in?[/say]")
		saynn("[say=pc]Guards and prisoners? Prisoners and prisoners? I'm sure there are plenty of things that people could use your skills in here.[/say]")
		saynn("He considers this for a moment")
		saynn("[say=azazel]Maybe... I need to sleep on it. I think. Thanks.[/say]")
		saynn("[say=pc]Of course, kitty.[/say]")
		saynn("He smiles at you, the conversation has ended.")
		addButton("Back", "End this conversation", "azazelmain")
		
	if state == "azazelmaster":
		saynn("[say=pc]So what do you think of your Master?[/say]")
		saynn("[say=azazel]My Master? Hmm. Back when I ended up in the prison he noticed me and gave place to be, he gave me protection, food - well, something else than the regular scrap you get in the prison kitchen, and helped me with my fears and anxiety I've had after coming in here. I really don't know what I'd do if he wasn't here, I think he... Saved me, you know? This place is scary in many ways if you don't have someone to show you around. Some may think that he is a bad person for simply what he has done to me or Lamia but he isn't.[/say]")
		saynn("[say=pc]Is he very strict with you?[/say]")
		saynn("[say=azazel]Not at all! He is a very understanding Master. He cares about us and does his best to keep us happy. What he asks of us is very little, I know how it sounds... But I speak from the bottom of my heart when I say it! He is a good Master.[/say]")
		saynn("[say=pc]Is that so? Hmm. How did you meet him?[/say]")
		saynn("He thinks for a second")
		saynn("[say=azazel]Well, I remember getting in here, being „processed” with the collar and all and basically pushed into new life. My first few days were spent trying to be quiet as a mouse *laughs*, everyone felt intimidating, and I've seen inmates getting harassed and used against their will. This seems to be the culture of this place, restraints are like free candy. There were one or two incidents I had with some bullies, I were assulted and used. One day Master Issix saw me hiding, he approached me and talked to me a bit, about why am I hiding, what am I doing in here and if someone is after me. From then I visited him daily, he... Grew on me. And one day he gave me a proposition to become his pet. At first I were hesitant, as anyone would be, but at the same time, he let himself be a very sweet person to me, and he never assulted me. So I accepted, and became his first sl- *he coughts* pet.[/say]")
		saynn("He smiles at you.")
		saynn("[say=azazel]I think he needed me as much as I needed him. So... Yeah. That's about it.[/say]")
		addButton("Back", "End this conversation", "azazelmain")

	if state == "azazelbreeding":
		saynn("[say=pc]Are you okey with your position as a breeder... Breeding bitch in the harem?[/say]")
		saynn("[say=azazel]Of course! Truth is, I'm the only one who can bear children out of us three... So of course I have huge responsibility. Master says that I'd be a good mother, haha. Can't test that theory in here, but oh well, I don't know. I don't really know why does Master want us to keep breeding, maybe he has something from it? He can't keep them either. Maybe that's just what he likes. Anyways, I don't mind. At this point I'm pretty good at making him litter, and I think he is proud of me too.[/say]")
		saynn("[say=oc]Doesn't it get tiring?[/say]")
		saynn("[say=azazel]Sometimes? I guess. I have those wants and needs when I'm pregnant, but Master always tries his best to keep me happy either way. And besides, if I'm not bred I tend to get really annoying, haha. Yeah...[/say]")
		addButton("Back", "End this conversation", "azazelmain")


	if state == "lamiatalk":
		addButton("Try drawing", "You can try and draw something with lamia", "lamiadraw")  # TODO

func _react(_action: String, _args):
	if(_action == "catnip"):
		GM.pc.getInventory().removeXOfOrDestroy("CatnipPlant", 1)
		GM.main.getCharacter("azazel").addLust(10)
		GM.main.increaseModuleFlag("IssixModule", "Azazel_Affection_given")
	
	if _action == "hiisienergy":
		GM.pc.getInventory().addItem(GlobalRegistry.createItem("EnergyDrink"))
	
	if(_action == "endthescene"):
		endScene()
		return

	setState(_action)
