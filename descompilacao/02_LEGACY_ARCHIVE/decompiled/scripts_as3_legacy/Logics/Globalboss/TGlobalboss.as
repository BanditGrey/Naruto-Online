package Logics.Globalboss
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TDafuben;
   import Processors.Game.Lobby.Globalboss.TUIGlobalBossStage;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TGlobalboss
   {
      
      public var stageId:int;
      
      public var starNum:int;
      
      public var Next:TGlobalboss;
      
      public var Current:TGlobalboss;
      
      public var PassIds:Vector.<int> = new Vector.<int>();
      
      public var GlobalbossStage:TUIGlobalBossStage;
      
      protected var FDafuben:TDafuben;
      
      protected var FStatus:int;
      
      public function TGlobalboss()
      {
         super();
      }
      
      public function get Dafuben() : TDafuben
      {
         this.FDafuben = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Dafuben,this.stageId) as TDafuben;
         return this.FDafuben;
      }
      
      public function get Status() : int
      {
         if(this.starNum > 0 && this.starNum < 3)
         {
            this.FStatus = 1;
         }
         else if(this.starNum == 3)
         {
            this.FStatus = 2;
         }
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
   }
}

