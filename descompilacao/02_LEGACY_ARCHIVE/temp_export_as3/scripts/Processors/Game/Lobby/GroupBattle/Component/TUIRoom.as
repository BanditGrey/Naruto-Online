package Processors.Game.Lobby.GroupBattle.Component
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TLeagueMapPve;
   import Logics.GroupBattle.TGroupBattleRoom;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_GROUPBATTLE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIRoom extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_RoomNum:TextField;
      
      protected var FTF_Population:TextField;
      
      protected var FTF_CaptainName:TextField;
      
      protected var FTF_BattleName:TextField;
      
      protected var FMC_Lock:MovieClip;
      
      protected var FMC_Select:Sprite;
      
      protected var FRoomUIOnClick:Function;
      
      public function TUIRoom(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_RoomNum = FResource["TF_RoomNum"];
         this.FTF_Population = FResource["TF_Population"];
         this.FTF_CaptainName = FResource["TF_CaptainName"];
         this.FTF_BattleName = FResource["TF_BattleName"];
         this.FMC_Lock = FResource["MC_Lock"];
         this.FMC_Select = FResource["MC_Select"];
         this.FMC_Select.visible = false;
         FResource.mouseChildren = false;
      }
      
      override protected function UILocations() : void
      {
         FResource.addEventListener(MouseEvent.CLICK,this.MCRoomUIOnClick,false,0,true);
         FResource.addEventListener(MouseEvent.MOUSE_MOVE,this.MCRoomUIOnMove,false,0,true);
         FResource.addEventListener(MouseEvent.ROLL_OUT,this.MCRoomUIOnOut,false,0,true);
         FResource.buttonMode = true;
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TGroupBattleRoom = null;
         var _loc2_:TLeagueMapPve = null;
         if(Context == null)
         {
            return;
         }
         _loc1_ = FContext as TGroupBattleRoom;
         this.FTF_RoomNum.text = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_ROOMID,_loc1_.RoomID);
         this.FTF_Population.text = TUtilityString.Format(STRING_GROUPBATTLE.FORMAT_Population,_loc1_.RoomPlayerCount);
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_LeagueMapPve,_loc1_.MissionID) as TLeagueMapPve;
         this.FTF_CaptainName.text = _loc1_.RoomName;
         this.FTF_BattleName.text = _loc2_.Name + STRING_GROUPBATTLE.STRING_Difficulties[_loc1_.MissionID % 10 - 1];
         this.FMC_Lock.visible = _loc1_.HasPassword;
      }
      
      protected function MCRoomUIOnClick(param1:MouseEvent) : void
      {
         if(this.FRoomUIOnClick != null)
         {
            this.FRoomUIOnClick(this,FContext);
         }
      }
      
      protected function MCRoomUIOnMove(param1:MouseEvent) : void
      {
         this.FMC_Select.visible = true;
      }
      
      protected function MCRoomUIOnOut(param1:MouseEvent) : void
      {
         this.FMC_Select.visible = false;
      }
      
      public function set RoomUIOnClick(param1:Function) : void
      {
         this.FRoomUIOnClick = param1;
      }
   }
}

