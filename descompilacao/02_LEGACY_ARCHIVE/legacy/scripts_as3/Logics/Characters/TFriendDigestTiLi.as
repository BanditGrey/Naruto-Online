package Logics.Characters
{
   public class TFriendDigestTiLi extends TDigest
   {
      
      protected var FIsGet:int;
      
      protected var FType:int;
      
      public function TFriendDigestTiLi(param1:uint, param2:uint)
      {
         super(param1,param2);
      }
      
      public function get IsGet() : int
      {
         return this.FIsGet;
      }
      
      public function set IsGet(param1:int) : void
      {
         this.FIsGet = param1;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function set Type(param1:int) : void
      {
         this.FType = param1;
      }
   }
}

