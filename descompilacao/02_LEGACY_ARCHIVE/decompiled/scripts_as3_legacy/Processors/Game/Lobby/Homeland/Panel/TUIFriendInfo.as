package Processors.Game.Lobby.Homeland.Panel
{
   import Components.Pages.TUIPage;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TMarryClass;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Processors.Game.Lobby.Married.TMarriedModel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIFriendInfo
   {
      
      protected var FMC_Scene:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      public function TUIFriendInfo(param1:MovieClip)
      {
         super();
         this.FMC_Scene = param1;
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            this.FMC_Scene["MC_Friend_" + _loc2_].visible = false;
            this.FMC_Scene["MC_Friend_" + _loc2_]["BTN_Help"].addEventListener(MouseEvent.CLICK,this.onHelpClick);
            TGameUtil.setButtonMode(this.FMC_Scene["MC_Friend_" + _loc2_]["BTN_Help"],true);
            _loc2_++;
         }
         this.FMC_Scene["BTN_Home"].addEventListener(MouseEvent.CLICK,this.onHomeClick);
         TGameUtil.setButtonMode(this.FMC_Scene.MC_PageLeft,true);
         TGameUtil.setButtonMode(this.FMC_Scene.MC_PageRight,true);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Home,false);
         this.FUIPage = new TUIPage(TUIComponent(param1.parent.parent));
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_Scene.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FMC_Scene.MC_PageRight;
         this.FUIPage.LabelPage = this.FMC_Scene.TF_Page;
         this.FUIPage.PageSize = 6;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.OnChangePage;
      }
      
      private function OnChangePage(param1:Object, param2:int) : void
      {
         this.UpdateUI();
      }
      
      public function UpdateUI() : void
      {
         var _loc4_:TMarryClass = null;
         this.FUIPage.TotalQuantity = THomelandModel.friendInfos.length;
         this.FUIPage.Update();
         var _loc1_:Vector.<Object> = THomelandModel.friendInfos.slice(this.FUIPage.PageIndex * this.FUIPage.PageSize,(this.FUIPage.PageIndex + 1) * this.FUIPage.PageSize);
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            this.FMC_Scene["MC_Friend_" + _loc2_].visible = _loc1_.length > _loc2_;
            if(this.FMC_Scene["MC_Friend_" + _loc2_].visible)
            {
               _loc4_ = THomelandModel.getMarryVOByExp(_loc1_[_loc2_].charm);
               this.FMC_Scene["MC_Friend_" + _loc2_]["TF_Name"].text = _loc1_[_loc2_].landName + " " + TIllustratedModel.TextFormat(70480029,this.getPick(_loc1_[_loc2_].landInfo));
            }
            _loc2_++;
         }
         _loc4_ = THomelandModel.getMarryVOByExp(THomelandModel.selfHome.charm);
         var _loc3_:String = TIllustratedModel.SystemLanguage.GetDatebaseByIdentifier(70480010)["Desc"];
         if(_loc3_)
         {
            this.FMC_Scene["TF_Pick"].text = TUtilityString.Format(_loc3_,_loc4_.FailRate - THomelandModel.selfHome.pick,_loc4_.FailRate);
         }
      }
      
      private function getPick(param1:Array) : int
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = TMarriedModel.CurrentServerTime - param1[_loc3_].time;
            if(param1[_loc3_].friendid_0 == 0 && param1[_loc3_].friendid_1 == 0 && _loc4_ >= THomelandModel.RoseTime[3])
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function onHelpClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget.parent as MovieClip;
         var _loc3_:int = int(_loc2_.name.split("MC_Friend_")[1]);
         _loc3_ += this.FUIPage.PageIndex * this.FUIPage.PageSize;
         THomelandModel.goHomeland(THomelandModel.friendInfos[_loc3_].Identifier0,THomelandModel.friendInfos[_loc3_].Identifier1);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Home,true);
      }
      
      private function onHomeClick(param1:MouseEvent) : void
      {
         THomelandModel.goHomeland(SLogicsCore.Character.Identifier0,SLogicsCore.Character.Identifier1);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_Home,false);
      }
   }
}

