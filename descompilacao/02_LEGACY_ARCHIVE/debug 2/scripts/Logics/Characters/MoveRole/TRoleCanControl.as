package Logics.Characters.MoveRole
{
   import Foundation.Common.Stubs.TStubReferences;
   import Logics.Spaces.LogicsSpace;
   import Logics.Wing.TWing;
   
   use namespace LogicsSpace;
   
   public class TRoleCanControl extends TRole
   {
      
      protected var FStubReferences:TStubReferences;
      
      protected var FLevel:uint;
      
      protected var FFamilyID:uint;
      
      protected var FMilitaryRank:uint;
      
      protected var FQuality:uint;
      
      protected var FChangeShape:Boolean;
      
      protected var FNewShapeBaseHeroID:uint;
      
      protected var FRelexBoo:Boolean;
      
      protected var FTextureID:uint;
      
      protected var FMapX:Number;
      
      protected var FMapY:Number;
      
      protected var FTitleID:uint;
      
      protected var FLittlePetID:uint;
      
      protected var FTransformID:uint;
      
      protected var FHideWing:int;
      
      public var BadgeList:Vector.<int>;
      
      public var Wing:TWing;
      
      public var JadeID:int;
      
      public function TRoleCanControl(param1:uint, param2:uint)
      {
         super(param1,param2);
         this.FStubReferences = new TStubReferences(this);
         this.BadgeList = new Vector.<int>();
         this.Wing = new TWing();
      }
      
      LogicsSpace function Coerce(param1:uint, param2:uint) : void
      {
         FIdentifier0 = param1;
         FIdentifier1 = param2;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get Level() : uint
      {
         return this.FLevel;
      }
      
      public function set Level(param1:uint) : void
      {
         this.FLevel = param1;
      }
      
      public function get MilitaryRank() : uint
      {
         return this.FMilitaryRank;
      }
      
      public function set MilitaryRank(param1:uint) : void
      {
         this.FMilitaryRank = param1;
      }
      
      public function get Quality() : uint
      {
         return this.FQuality;
      }
      
      public function set Quality(param1:uint) : void
      {
         this.FQuality = param1;
      }
      
      public function get ChangeShape() : Boolean
      {
         return this.FChangeShape;
      }
      
      public function set ChangeShape(param1:Boolean) : void
      {
         this.FChangeShape = param1;
      }
      
      public function get NewShapeBaseHeroID() : uint
      {
         return this.FNewShapeBaseHeroID;
      }
      
      public function set NewShapeBaseHeroID(param1:uint) : void
      {
         this.FNewShapeBaseHeroID = param1;
      }
      
      public function get RelexBoo() : Boolean
      {
         return this.FRelexBoo;
      }
      
      public function set RelexBoo(param1:Boolean) : void
      {
         this.FRelexBoo = param1;
      }
      
      public function get TextureID() : uint
      {
         return this.FTextureID;
      }
      
      public function set TextureID(param1:uint) : void
      {
         this.FTextureID = param1;
      }
      
      public function get MapX() : Number
      {
         return this.FMapX;
      }
      
      public function set MapX(param1:Number) : void
      {
         this.FMapX = param1;
      }
      
      public function get MapY() : Number
      {
         return this.FMapY;
      }
      
      public function set MapY(param1:Number) : void
      {
         this.FMapY = param1;
      }
      
      public function get FamilyID() : uint
      {
         return this.FFamilyID;
      }
      
      public function set FamilyID(param1:uint) : void
      {
         this.FFamilyID = param1;
      }
      
      public function get TitleID() : uint
      {
         return this.FTitleID;
      }
      
      public function set TitleID(param1:uint) : void
      {
         this.FTitleID = param1;
      }
      
      public function get LittlePetID() : uint
      {
         return this.FLittlePetID;
      }
      
      public function set LittlePetID(param1:uint) : void
      {
         this.FLittlePetID = param1;
      }
      
      public function get TransformID() : uint
      {
         return this.Wing.TransformID;
      }
      
      public function set TransformID(param1:uint) : void
      {
         this.Wing.TransformID = param1;
      }
      
      public function get HideWing() : int
      {
         return this.Wing.HideWing;
      }
      
      public function set HideWing(param1:int) : void
      {
         this.Wing.HideWing = param1;
      }
   }
}

