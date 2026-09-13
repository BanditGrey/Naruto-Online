package Processors.Game.Lobby.SystemActivity.Components
{
   import Foundation.UI.TUIComponent;
   import Logics.SLogicsCore;
   import Logics.SystemActivity.TSystemActivity;
   import Resources.Constants.CONST_SYSTEMACTIVITY;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TUINormalList extends TUIComponent
   {
      
      public static const ROW_COUNT:int = 3;
      
      public static const COL_COUNT:int = 3;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FNameList:Vector.<TextField>;
      
      protected var FIndex:int;
      
      protected var FInitialized:Boolean;
      
      public function TUINormalList(param1:TUIComponent)
      {
         super(param1);
         this.FNameList = new Vector.<TextField>(ROW_COUNT * COL_COUNT);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         _loc2_ = 0;
         while(_loc2_ < ROW_COUNT * COL_COUNT)
         {
            this.FNameList[_loc2_] = this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_Name + _loc2_];
            _loc2_++;
         }
      }
      
      protected function UpdateList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TSystemActivity = SLogicsCore.SystemActivities.GetSystemActivityByIndex(this.FIndex);
         _loc1_ = 0;
         while(_loc1_ < COL_COUNT * ROW_COUNT)
         {
            this.FNameList[_loc1_].text = _loc2_.GetOrgNameByRank(_loc1_ / 3 + 1,_loc1_ % 3 + 1);
            _loc1_++;
         }
      }
      
      public function get Index() : int
      {
         return this.FIndex;
      }
      
      public function set Index(param1:int) : void
      {
         this.FIndex = param1;
         this.UpdateList();
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         if(this.FInitialized && this.Visible)
         {
         }
      }
   }
}

