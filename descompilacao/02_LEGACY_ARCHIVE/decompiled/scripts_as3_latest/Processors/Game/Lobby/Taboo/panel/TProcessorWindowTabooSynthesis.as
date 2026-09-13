package Processors.Game.Lobby.Taboo.panel
{
   import Components.Standard.TUITab;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Taboo.Cell.Slot_taboo;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_TABOO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TABOO;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTabooSynthesis extends TProcessorLobbyWindow
   {
      
      public static const Seven:int = 7;
      
      public static const Three:int = 3;
      
      public static const SIX:int = 6;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FUITabHeros:TUITab;
      
      protected var FUITab:TUITab;
      
      protected var FCurTabIndex:int;
      
      protected var FTabTypedex:int;
      
      protected var FCurData:TabooDataCell = null;
      
      protected var TempDate:TabooDataCell = null;
      
      protected var CurSlot:Slot_taboo = null;
      
      protected var VecSlot:Vector.<Slot_taboo> = null;
      
      protected var FMC_Btn_Make:MovieClip = null;
      
      protected var FTF_Name:TextField = null;
      
      protected var FTF_Dec:TextField = null;
      
      protected var FMC_eFFECT_:MovieClip = null;
      
      protected var FSlotsOnMove:Function = null;
      
      protected var FSlotsOnOut:Function = null;
      
      protected var FMakeFun:Function;
      
      public function TProcessorWindowTabooSynthesis(param1:TUIComponent)
      {
         super(param1);
         this.FUITabHeros = new TUITab(this);
         this.FUITab = new TUITab(this);
         this.FCurData = new TabooDataCell();
         this.TempDate = new TabooDataCell();
         this.VecSlot = new Vector.<Slot_taboo>(Three);
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
         this.initilization();
      }
      
      protected function initilization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:Slot_taboo = null;
         this.FMC_Btn_Make = this.FThisPanel["MC_Btn_Make"];
         this.FTF_Name = this.FThisPanel["TF_Name"];
         this.FTF_Dec = this.FThisPanel["TF_Dec"];
         this.FMC_eFFECT_ = this.FThisPanel["MC_eFFECT_"];
         this.CurSlot = new Slot_taboo();
         this.CurSlot.SetPanel(this.FThisPanel["MC_Slot_"]);
         this.CurSlot.SlotsOnM = this.SlotsOnM;
         this.CurSlot.SlotsOnO = this.SlotsOnO;
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc3_ = new Slot_taboo();
            _loc3_.SetPanel(this.FThisPanel["MC_Slot_" + _loc1_]);
            _loc3_.IsAddEventListener();
            _loc3_.SlotsOnM = this.SlotsOnM;
            _loc3_.SlotsOnO = this.SlotsOnO;
            this.VecSlot[_loc1_] = _loc3_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < Seven)
         {
            _loc2_ = this.FThisPanel["TF_HeroName_" + _loc1_];
            this.FUITabHeros.SetTabByIndex(_loc2_,_loc1_);
            this.FUITabHeros.SetTabCaptionByIndex(STRING_TABOO.RankStr[_loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITabHeros.OnSwitch = this.TabHerosOnSwitch;
         this.FUITabHeros.Init();
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Name_0"],0);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Name_1"],1);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Name_2"],2);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Name_3"],3);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Name_4"],4);
         this.FUITab.SetTabByIndex(this.FThisPanel["MC_Name_5"],5);
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FUITab.SetTabHideByIndexCopy(3);
         this.addListener();
      }
      
      public function SetVisibel(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            MovieClip(this.FUITab.GetMoviClipByIndex(_loc2_)["MC_Num"]).visible = param1;
            _loc2_++;
         }
      }
      
      public function addListener() : void
      {
         this.FMC_Btn_Make.addEventListener(MouseEvent.CLICK,this.HandleClick);
      }
      
      protected function TabHerosOnSwitch(param1:Object) : void
      {
         this.FTabTypedex = param1 as int;
         this.UpdateSevenCy();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FCurTabIndex = param1 as int;
         this.UpdateSevenCy();
      }
      
      public function OpenThisPanel() : void
      {
         this.UpdateSevenCy();
      }
      
      public function UpdateSevenCy() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:TabooDataCell = null;
         _loc1_ = CONST_TABOO.Configuration_Base + (this.FCurTabIndex + 1) * 1000 + (this.FTabTypedex + 1);
         this.FCurData.SetValueById(_loc1_);
         this.CurSlot.SetData(this.FCurData);
         this.CurSlot.SetCount(1);
         this.FTF_Name.text = this.FCurData.ConfigureConfig.Name;
         _loc3_ = this.FCurData.ConfigureAddition.AddProperty;
         var _loc5_:String = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc3_[0][0])] + "+" + _loc3_[0][1];
         if(_loc3_.length > 1)
         {
            _loc5_ = STRING_TABOO.Str23 + "+" + _loc3_[0][1];
         }
         this.FTF_Dec.text = _loc5_;
         _loc3_ = this.FCurData.ConfigureAddition.SMaterialArr;
         _loc2_ = 0;
         while(_loc2_ < Three)
         {
            if(_loc2_ < _loc3_.length)
            {
               _loc4_ = new TabooDataCell();
               _loc4_.SetValueById(_loc3_[_loc2_][0]);
               this.VecSlot[_loc2_].SetData(_loc4_);
               this.VecSlot[_loc2_].SetCount(SLogicsCore.TBooData.GetCountById(_loc3_[_loc2_][0]),_loc3_[_loc2_][1],0);
            }
            else
            {
               this.VecSlot[_loc2_].SetData(null);
            }
            _loc2_++;
         }
         this.UpdateCanHeChengNum();
      }
      
      protected function UpdateCanHeChengNum() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < SIX)
         {
            _loc2_ = CONST_TABOO.Configuration_Base + (_loc1_ + 1) * 1000 + (this.FTabTypedex + 1);
            this.TempDate.SetValueById(_loc2_);
            _loc3_ = this.TempDate.ConfigureAddition.SMaterialArr;
            _loc6_ = 0;
            while(_loc6_ < Three)
            {
               _loc4_ = int(SLogicsCore.TBooData.GetCountById(_loc3_[_loc6_][0]));
               _loc4_ = _loc4_ / _loc3_[_loc6_][1];
               switch(_loc6_)
               {
                  case 0:
                     _loc7_ = _loc4_;
                     break;
                  case 1:
                     _loc8_ = _loc4_;
                     break;
                  case 2:
                     _loc9_ = _loc4_;
               }
               _loc6_++;
            }
            _loc4_ = Math.min(_loc7_,_loc8_,_loc9_);
            _loc5_ = this.FUITab.GetMoviClipByIndex(_loc1_);
            if(_loc5_)
            {
               TextField(_loc5_["MC_Num"]["TF_Caption"]).text = _loc4_.toString();
            }
            _loc1_++;
         }
         _loc5_ = this.FUITab.GetMoviClipByIndex(this.FCurTabIndex);
         _loc2_ = uint(int(TextField(_loc5_["MC_Num"]["TF_Caption"]).text));
         if(_loc2_ > 0)
         {
            TGameUtil.setButtonMode(this.FMC_Btn_Make,true);
         }
         else
         {
            TGameUtil.setButtonMode(this.FMC_Btn_Make,false);
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
         this.CurSlot.UpdateImage();
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            this.VecSlot[_loc1_].UpdateImage();
            _loc1_++;
         }
      }
      
      public function set MakeFun(param1:Function) : void
      {
         this.FMakeFun = param1;
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Btn_Make:
               if(this.FMC_Btn_Make.buttonMode)
               {
                  if(this.FMakeFun != null)
                  {
                     this.FMakeFun(this.FCurData);
                  }
               }
         }
      }
      
      public function get ThisPanel() : MovieClip
      {
         return this.FThisPanel;
      }
   }
}

