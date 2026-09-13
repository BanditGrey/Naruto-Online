package Logics.Characters
{
   import Resources.Constants.CONST_FRIEND;
   
   public class TFriendDigest extends TDigest
   {
      
      public static const TYPE_White:uint = CONST_FRIEND.TYPE_White;
      
      public static const TYPE_Black:uint = CONST_FRIEND.TYPE_Black;
      
      public static const TYPE_Recommend:uint = CONST_FRIEND.TYPE_Recommend;
      
      protected var FType:uint;
      
      protected var FCountry:uint;
      
      protected var FIsOnline:Boolean;
      
      protected var FTag:uint;
      
      public function TFriendDigest(param1:uint, param2:uint)
      {
         super(param1,param2);
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get Country() : uint
      {
         return this.FCountry;
      }
      
      public function set Country(param1:uint) : void
      {
         this.FCountry = param1;
      }
      
      public function get IsOnline() : Boolean
      {
         return this.FIsOnline;
      }
      
      public function set IsOnline(param1:Boolean) : void
      {
         this.FIsOnline = param1;
      }
      
      public function get Tag() : uint
      {
         return this.FTag;
      }
      
      public function set Tag(param1:uint) : void
      {
         this.FTag = param1;
      }
      
      override public function Setup(param1:TCharacter) : void
      {
         super.Setup(param1);
         this.FCountry = param1.Country;
      }
      
      override public function Reset() : void
      {
         super.Reset();
         this.FType = 0;
         this.FCountry = 0;
         this.FIsOnline = false;
         this.FTag = 0;
      }
   }
}

