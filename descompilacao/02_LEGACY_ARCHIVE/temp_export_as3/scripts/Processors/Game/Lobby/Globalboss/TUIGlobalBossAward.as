package Processors.Game.Lobby.Globalboss
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TDafubenAward;
   import Logics.Globalboss.TGlobalbossChapter;
   import Logics.Inventories.TInventory;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import flash.display.MovieClip;
   
   public class TUIGlobalBossAward
   {
      
      protected var MCResource:MovieClip;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FParent:TUIComponent;
      
      protected var FSlotsOnOver:Function;
      
      protected var FSlotsOnOut:Function;
      
      public function TUIGlobalBossAward(param1:TUIComponent)
      {
         super();
         this.FParent = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.FShowItem = new TUIShowItem(this.FParent,2);
         this.FShowItem.Perform_UIDispatch(param1.MC_Award);
         this.FShowItem.OnOverlay = this.PerformOnOverlay;
         this.FShowItem.OnOut = this.PerformOnOut;
         this.MCResource = param1;
      }
      
      public function SetDate(param1:TDafubenAward, param2:TGlobalbossChapter) : void
      {
         if(this.FShowItem)
         {
            this.FShowItem.UpdateUI(param1.AwardList);
         }
         this.MCResource.TF_Achieve.text = TUtilityString.Format(param1.Stardec,param2.starNum);
      }
      
      public function LogicsPerform() : void
      {
         if(this.FShowItem)
         {
            this.FShowItem.LogicsPerform();
         }
      }
      
      protected function PerformOnOverlay(param1:Object, param2:TInventory) : void
      {
         if(this.FSlotsOnOver != null)
         {
            this.FSlotsOnOver(param1,param2);
         }
      }
      
      protected function PerformOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FSlotsOnOut != null)
         {
            this.FSlotsOnOut(param1,param2);
         }
      }
      
      public function set SlotsOnOver(param1:Function) : void
      {
         this.FSlotsOnOver = param1;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
   }
}

