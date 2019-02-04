//
//  NotesListData.swift
//  Notes
//
//  Created by Artem Karmaz on 1/30/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation


class Notes {
    var list = [
        Lists(name: "Shakespeare - Hamlet"),
        Lists(name: "shopping list for tomorrow"),
        Lists(name: "My thoughts")
    ]
    
    
    var notesList = ["Shakespeare - Hamlet", "shopping list for tomorrow", "My thoughts"]
    var filteredList = ""
    var numberOfNote = 0
}

class NotesData {
    var testNote1 = """
        (from Hamlet, spoken by Hamlet)
        To be, or not to be, that is the question:
        Whether 'tis nobler in the mind to suffer
        The slings and arrows of outrageous fortune,
        Or to take arms against a sea of troubles
        And by opposing end them. To die—to sleep,
        No more; and by a sleep to say we end
        The heart-ache and the thousand natural shocks
        That flesh is heir to: 'tis a consummation
        Devoutly to be wish'd. To die, to sleep;
        To sleep, perchance to dream—ay, there's the rub:
        For in that sleep of death what dreams may come,
        When we have shuffled off this mortal coil,
        Must give us pause—there's the respect
        That makes calamity of so long life.
        For who would bear the whips and scorns of time,
        Th'oppressor's wrong, the proud man's contumely,
        The pangs of dispriz'd love, the law's delay,
        The insolence of office, and the spurns
        That patient merit of th'unworthy takes,
        When he himself might his quietus make
        With a bare bodkin? Who would fardels bear,
        To grunt and sweat under a weary life,
        But that the dread of something after death,
        The undiscovere'd country, from whose bourn
        No traveller returns, puzzles the will,
        And makes us rather bear those ills we have
        Than fly to others that we know not of?
        Thus conscience does make cowards of us all,
        And thus the native hue of resolution
        Is sicklied o'er with the pale cast of thought,
        And enterprises of great pitch and moment
        With this regard their currents turn awry
        And lose the name of action.
        """
    var testNote2 = """
        Buy:
        
        1) Eggs
        2) Milk
        3) Sugar
        4) Meat
        5) Bread
        6) Fish
        7) Apples
        """
    var testNote3 = """
        The art of V. Shukshin as a writer, actor, playwright cannot leave anyone indifferent. Let us ask ourselves the question: what are the works of Shukshin being taken for the heart and soul? The answer is simple: the peasant son, he not only knew the rural life in all its subtleties, he “sensed” it with his gut, heart, all his nature, because his characters are so natural, true with every act, gesture, speech, life. And the pain that permeated almost all the works of the writer. Pain for a man - for his failed fate ("Zaletny"), trampled dignity ("Offense"), grief, with which no one can miss each other in this life ("Grief").

        How many in Russian, in all of world literature, it is written - probably hundreds of thousands of pages - about the death and grief of loneliness that it carries. And as written! Handsomely!

        But Vasily Shukshin writes a short story, which calls it “Woe”. And shocking the souls and hearts of readers. The whole story told by the writer is ordinary, everyday: the old Nechaya’s wife died, he buried her, but he cannot recover from the misfortune leaning on him. At night, she goes out into the garden and “talks” with the deceased. It is no longer a man who speaks - human pain itself, human woe. The story "Woe" is a true masterpiece. And it could only be written by a person who feels another's pain stronger than his own.

        Shukshin himself constantly doubts, painfully reflects on our life, on its meaning, asks itself endless questions, gives often unsatisfactory answers to them. And many of his characters are like their creator - restless, often acting contrary to common sense, to their detriment. But always the writer honored in a person sincerity, integrity, a good start. Even in his most misguided hero, he wanted to see something good, elevating him above the prose of life.

        All Shukshin "cranks" are, in essence, people with unmet spiritual need. Hence their eccentricities, sometimes completely innocent, sometimes to the point of breaking the law and even beyond this limit. The earth and people today, their being, their future destinies — this is what worries the writer, catches his attention. Love, friendship, filial and fatherly feelings, motherhood in the infinity of patience and kindness - through them one recognizes a person, and through him one can recognize time and the essence of being.

        Vasily Shukshin knew and perfectly understood life. His knowledge consisted of personal experience, observations, insightful vision, from his art to understand, to unravel the essence of phenomena and facts, to compare them, to compare.

        Shukshin is the son of his land and of his time; he belongs to the category of writers, by whom talent, measured by nature, allows him to step into the future. And today, just as alarmingly as twenty years ago, his question sounds: "What is happening to us?"
        """
}
