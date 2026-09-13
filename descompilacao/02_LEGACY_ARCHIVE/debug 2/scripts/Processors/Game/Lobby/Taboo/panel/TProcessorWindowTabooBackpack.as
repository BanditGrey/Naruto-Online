package Processors.Game.Lobby.Taboo.panel
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.UI.TUIComponent;
   import Logics.Characters.TCharacter;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Taboo.Cell.Slot_taboo;
   import Processors.Game.Lobby.Taboo.Data.TabooData;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Resources.Strings.STRING_TABOO;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TProcessorWindowTabooBackpack extends TProcessorLobbyWindow
   {
      
      public static const three:int = 3;
      
      public static const sixty:int = 45;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FDta:TabooData = null;
      
      protected var FCharacter:TCharacter;
      
      protected var FUITabHeros:TUITab;
      
      protected var FTabTypedex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FHeroPageIndex:int;
      
      protected var FTabHeroIndex:int;
      
      protected var FSlotVectoer:Vector.<Slot_taboo>;
      
      protected var FCurVec:Vector.<TabooDataCell> = null;
      
      protected var FSlotsOnMove:Function = null;
      
      protected var FSlotsOnOut:Function = null;
      
      public function TProcessorWindowTabooBackpack(param1:TUIComponent)
      {
         super(param1);
         this.FSlotVectoer = new Vector.<Slot_taboo>(sixty);
         this.FUITabHeros = new TUITab(this);
         this.FUIPage = new TUIPage(this);
      }
      
      public function set SlotsOnMove(param1:Function) : void
      {
         this.FSlotsOnMove = param1;
      }
      
      public function set SlotsOnOut(param1:Function) : void
      {
         this.FSlotsOnOut = param1;
      }
      
      protected function SlotsOnM(param1:Object, param2:Object) : void
      {
         this.FSlotsOnMove(param1,param2);
      }
      
      protected function SlotsOnO(param1:Object, param2:Object) : void
      {
         this.FSlotsOnOut(param1,param2);
      }
      
      public function SetPanel(param1:MovieClip) : void
      {
         this.FThisPanel = param1;
         this.FDta = SLogicsCore.TBooData;
         this.FCharacter = SLogicsCore.Character;
         this.initilization();
      }
      
      protected function initilization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Slot_taboo = null;
         var _loc3_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < three)
         {
            _loc3_ = this.FThisPanel["TF_HeroName_" + _loc1_];
            this.FUITabHeros.SetTabByIndex(_loc3_,_loc1_);
            this.FUITabHeros.SetTabCaptionByIndex(STRING_TABOO.TabStr[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITabHeros.OnSwitch = this.TabHerosOnSwitch;
         this.FUITabHeros.Init();
         _loc1_ = 0;
         while(_loc1_ < sixty)
         {
            _loc2_ = new Slot_taboo();
            _loc2_.SetPanel(this.FThisPanel["MC_Slot_" + _loc1_]);
            _loc2_.SlotsOnM = this.SlotsOnM;
            _loc2_.SlotsOnO = this.SlotsOnO;
            this.FSlotVectoer[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.FUIPage.ButtonPrevious.Substrate = this.FThisPanel["MC_PageLeft"];
         this.FUIPage.ButtonNext.Substrate = this.FThisPanel["MC_PageRight"];
         this.FUIPage.LabelPage = this.FThisPanel["TF_Page"];
         TextField(this.FThisPanel["TF_Page"]).text = "0/0";
         this.FUIPage.PageSize = sixty;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.HeroPageOnChange;
      }
      
      protected function TabHerosOnSwitch(param1:Object) : void
      {
         this.FTabTypedex = param1 as int;
         this.FHeroPageIndex = 0;
         this.FTabHeroIndex = 0;
         this.UpdateSevenCy();
         this.UpdateHeroUIPage();
      }
      
      protected function HeroPageOnChange(param1:Object, param2:int) : void
      {
         this.FHeroPageIndex = param2;
         this.FTabHeroIndex = 0;
         this.FTabHeroIndex = this.FHeroPageIndex * sixty;
         this.UpdateSevenCy();
         this.UpdateHeroUIPage();
      }
      
      public function UpdateHeroUIPage() : void
      {
         this.FUIPage.TotalQuantity = this.FCurVec.length;
         this.FUIPage.PageIndex = this.FHeroPageIndex;
         this.FUIPage.Update();
      }
      
      public function OpenThisPanel() : void
      {
         this.TabHerosOnSwitch(0);
         this.FUITabHeros.Reset();
      }
      
      protected function UpdateSevenCy() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.FCurVec = this.FDta.GetVectorByType(this.FTabTypedex + 1);
         _loc3_ = int(this.FCurVec.length);
         _loc1_ = 0;
         while(_loc1_ < sixty)
         {
            _loc4_ = _loc1_ + this.FHeroPageIndex * sixty;
            if(_loc4_ >= _loc3_)
            {
               this.FSlotVectoer[_loc1_].SetData(null);
            }
            else
            {
               this.FSlotVectoer[_loc1_].SetData(this.FCurVec[_loc4_]);
            }
            _loc1_++;
         }
      }
      
      public function UpdateEnterFream() : void
      {
         var _loc1_:int = 0;
         if(!this.FThisPanel)
         {
            return;
         }
         if(!this.FThisPanel.visible)
         {
            return;
         }
         if(!this.FCurVec)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < sixty)
         {
            this.FSlotVectoer[_loc1_].UpdateImage();
            _loc1_++;
         }
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
   }
}

