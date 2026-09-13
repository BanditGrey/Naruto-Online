package Processors.Game.Lobby.awaken.Panel
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Processors.Game.Lobby.awaken.cell.BaseCell;
   import Processors.Game.Lobby.awaken.date.AwakenDateCELL;
   import Processors.Game.Lobby.awaken.date.AwakenLogicDate;
   import Processors.Game.TProcessorGame;
   import Resources.Constants.CONST_AWAKEN;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_AWAKEN;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TProcessorWindowManSkillPanel extends TProcessorGame
   {
      
      public static const TEN:int = 12;
      
      public static const TWO:int = 2;
      
      public static const TWOFIVE:int = 20;
      
      protected var FThisPanel:Sprite = null;
      
      protected var FUIPage:TUIPage;
      
      protected var FHeroPageIndex:int;
      
      protected var FTabHeroIndex:int;
      
      protected var FUITabSkill:TUITab;
      
      protected var FTabSkillIndex:int;
      
      protected var FSkillPage:TUIPage = null;
      
      protected var FSkillPageIndex:int;
      
      protected var FSkillIndex:int;
      
      protected var FUITabHeros:TUITab;
      
      protected var FCurrentRole:THero;
      
      protected var FCharacter:TCharacter = SLogicsCore.Character;
      
      protected var FLogicDate:AwakenLogicDate = SLogicsCore.AwakenDate;
      
      protected var FMC_PuTongSlot:BaseCell = new BaseCell();
      
      protected var FPuTongAwakenDateCELL:AwakenDateCELL = new AwakenDateCELL();
      
      protected var FTF_PuTongSkillDec:TextField = null;
      
      protected var FTF_PuTongSkillName:TextField = null;
      
      protected var FMC_TeShuSlot:BaseCell = new BaseCell();
      
      protected var FTeShuAwakenDateCELL:AwakenDateCELL = new AwakenDateCELL();
      
      protected var FTF_TeShuSkillDec:TextField = null;
      
      protected var FTF_TeShuSkillName:TextField = null;
      
      protected var FTF_PuTongAddGold:TextField = null;
      
      protected var FTF_TeShuAddGold:TextField = null;
      
      protected var SlotVec:Vector.<BaseCell> = new Vector.<BaseCell>(TWOFIVE);
      
      protected var CurDateVec:Vector.<AwakenDateCELL>;
      
      protected var FCloseFunction:Function = null;
      
      protected var FBackOver:Function;
      
      protected var FBackOut:Function;
      
      protected var FBackMove:Function;
      
      protected var FBackClick:Function;
      
      protected var FTextFormat:TextFormat = new TextFormat();
      
      protected var CurAwakenDateCELL:AwakenDateCELL;
      
      protected var CurType:int;
      
      public function TProcessorWindowManSkillPanel(param1:TUIComponent)
      {
         this.FUIPage = new TUIPage(param1);
         this.FUITabHeros = new TUITab(param1);
         this.FUITabSkill = new TUITab(param1);
         this.FSkillPage = new TUIPage(param1);
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_AWAKEN.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:BaseCell = null;
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("MC_EquipSkill") as Sprite;
         this.addChild(this.FThisPanel);
         this.x = (FUICore.StageWidth - this.width) / 2;
         this.y = (FUICore.StageHeight - this.height) / 2;
         this.FMC_PuTongSlot.SetPanel(this.FThisPanel["MC_PuTongSlot"]);
         this.FMC_PuTongSlot.BackOver = this.FBackOver;
         this.FMC_PuTongSlot.BackOut = this.FBackOut;
         this.FMC_PuTongSlot.BackMove = this.FBackMove;
         this.FMC_PuTongSlot.BackClick = this.FBackClickC;
         new Tools_Help(Parent,this.FThisPanel["MC_Help"],70170091,FUICore);
         this.FTF_PuTongSkillDec = this.FThisPanel["TF_PuTongSkillDec"];
         this.FTF_PuTongSkillName = this.FThisPanel["TF_PuTongSkillName"];
         this.FTF_TeShuSkillDec = this.FThisPanel["TF_TeShuSkillDec"];
         this.FTF_TeShuSkillName = this.FThisPanel["TF_TeShuSkillName"];
         this.FTF_PuTongAddGold = this.FThisPanel["TF_PuTongAddGold"];
         this.FTF_TeShuAddGold = this.FThisPanel["TF_TeShuAddGold"];
         this.FMC_TeShuSlot.SetPanel(this.FThisPanel["MC_TeShuSlot"]);
         this.FMC_TeShuSlot.BackOver = this.FBackOver;
         this.FMC_TeShuSlot.BackOut = this.FBackOut;
         this.FMC_TeShuSlot.BackMove = this.FBackMove;
         this.FMC_TeShuSlot.BackClick = this.FBackClickC;
         this.FUIPage.ButtonPrevious.Substrate = this.FThisPanel["MC_HeroPage"]["MC_PageLeft"];
         this.FUIPage.ButtonNext.Substrate = this.FThisPanel["MC_HeroPage"]["MC_PageRight"];
         this.FUIPage.LabelPage = this.FThisPanel["MC_HeroPage"]["TF_Page"];
         TextField(this.FThisPanel["MC_HeroPage"]["TF_Page"]).text = "0/0";
         this.FUIPage.PageSize = TEN;
         this.FUIPage.Init();
         this.FUIPage.OnChangePage = this.HeroPageOnChange;
         _loc1_ = 0;
         while(_loc1_ < TEN)
         {
            _loc2_ = this.FThisPanel["General_" + _loc1_];
            this.FUITabHeros.SetTabByIndex(_loc2_,_loc1_);
            this.FUITabHeros.SetTabCaptionByIndex("",_loc1_);
            _loc1_++;
         }
         this.FUITabHeros.OnSwitch = this.TabHerosOnSwitch;
         this.FUITabHeros.Init();
         _loc1_ = 0;
         while(_loc1_ < TWO)
         {
            _loc2_ = this.FThisPanel["MC_Tab_" + _loc1_];
            this.FUITabSkill.SetTabByIndex(_loc2_,_loc1_);
            _loc1_++;
         }
         this.FUITabSkill.OnSwitch = this.TabSkillOnSwitch;
         this.FUITabSkill.Init();
         _loc1_ = 0;
         while(_loc1_ < TWOFIVE)
         {
            _loc3_ = new BaseCell();
            _loc3_.SetPanel(this.FThisPanel["MC_Slot_" + _loc1_]);
            _loc3_.BackOver = this.FBackOver;
            _loc3_.BackOut = this.FBackOut;
            _loc3_.BackMove = this.FBackMove;
            _loc3_.BackClick = this.FBackClickB;
            this.SlotVec[_loc1_] = _loc3_;
            _loc1_++;
         }
         this.FSkillPage.ButtonPrevious.Substrate = this.FThisPanel["MC_Page"]["MC_PageLeft"];
         this.FSkillPage.ButtonNext.Substrate = this.FThisPanel["MC_Page"]["MC_PageRight"];
         this.FSkillPage.LabelPage = this.FThisPanel["MC_Page"]["TF_Page"];
         TextField(this.FThisPanel["MC_Page"]["TF_Page"]).text = "1/1";
         this.FSkillPage.PageSize = TWOFIVE;
         this.FSkillPage.Init();
         this.FSkillPage.OnChangePage = this.SkillPageOnChange;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.AddEventlistener();
         super.ResourcesPerform_UILocations();
      }
      
      protected function AddEventlistener() : void
      {
         SimpleButton(this.FThisPanel["btn_Close"]).addEventListener(MouseEvent.CLICK,this.HandleClick);
         super.LogicsPerform();
      }
      
      protected function TabSkillOnSwitch(param1:Object) : void
      {
         this.FTabSkillIndex = param1 as int;
         this.ChangVec();
         this.FSkillIndex = 0;
         this.UpdateHeChengPage();
         this.UpdateSlot();
      }
      
      public function ChangVec() : void
      {
         if(this.FTabSkillIndex == 0)
         {
            this.CurDateVec = this.FLogicDate.GetVectorByType(4);
         }
         else
         {
            this.CurDateVec = this.FLogicDate.GetVectorByType(3);
         }
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < TWOFIVE)
         {
            _loc2_ = _loc1_ + this.FSkillIndex * TWOFIVE;
            if(_loc2_ >= this.CurDateVec.length)
            {
               this.SlotVec[_loc1_].SetDate(null);
            }
            else
            {
               this.SlotVec[_loc1_].SetDate(this.CurDateVec[_loc2_]);
            }
            _loc1_++;
         }
         this.UpdateHeChengPage();
      }
      
      protected function UpdateHeroPage() : void
      {
         this.FUIPage.TotalQuantity = this.FCharacter.Heros.Count;
         this.FUIPage.PageIndex = this.FHeroPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateHeChengPage() : void
      {
         this.FSkillPage.TotalQuantity = this.CurDateVec.length;
         this.FSkillPage.PageIndex = this.FSkillIndex;
         this.FSkillPage.Update();
      }
      
      protected function SkillPageOnChange(param1:Object, param2:int) : void
      {
         this.FSkillIndex = param2;
         this.FSkillPageIndex = 0;
         this.FSkillPageIndex += this.FSkillIndex * TWOFIVE;
         this.UpdateSlot();
      }
      
      protected function HeroPageOnChange(param1:Object, param2:int) : void
      {
         this.FHeroPageIndex = param2;
         this.FTabHeroIndex = 0;
         this.FTabHeroIndex = this.FHeroPageIndex * TEN;
         this.UpdateTabs();
         this.FUITabHeros.SwithTagManual(0);
      }
      
      protected function TabHerosOnSwitch(param1:Object) : void
      {
         this.FTabHeroIndex = param1 as int;
         this.FTabHeroIndex += this.FHeroPageIndex * TEN;
         this.UpdateRoleSkill();
      }
      
      public function OpenThisPanel() : void
      {
         this.FTabHeroIndex = 0;
         this.FHeroPageIndex = 0;
         this.FTabHeroIndex = 0;
         this.UpdateTabs();
         this.FUITabHeros.SwithTagManual(this.FTabHeroIndex);
         this.FTabSkillIndex = 0;
         this.UpdateHeroPage();
         this.ChangVec();
         this.FUITabSkill.SwithTagManual(this.FTabSkillIndex);
         this.UpdateSlot();
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THeros = null;
         var _loc4_:THero = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc3_ = this.FCharacter.Heros;
         _loc3_.Sort();
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < TEN)
         {
            _loc6_ = _loc1_ + this.FHeroPageIndex * TEN;
            if(_loc6_ >= _loc2_)
            {
               this.FUITabHeros.SetTabHideByIndex(_loc1_);
            }
            else
            {
               _loc4_ = _loc3_.GetHeroByIndex(_loc6_);
               _loc5_ = CONST_COMMON.QUALITYCOLOR_INDEX[_loc4_.Quality];
               this.FUITabHeros.SetTabCaptionByIndex(_loc4_.Name,_loc1_,_loc5_);
               this.FUITabHeros.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
         this.UpdateRoleSkill();
      }
      
      protected function UpdateRoleSkill() : void
      {
         this.FCurrentRole = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         this.UpdateTwoBaseCell();
      }
      
      public function UpdateTwoBaseCell() : void
      {
         if(this.FCurrentRole)
         {
            if(this.FCurrentRole.AwakenCommonSkillId == 0)
            {
               this.FMC_PuTongSlot.SetDate(null);
               this.FTF_PuTongSkillDec.text = "";
               this.FTF_PuTongSkillName.text = "";
               this.FTF_PuTongAddGold.text = STRING_AWAKEN.Str777;
               if(this.FBackOut != null)
               {
                  this.FBackOut(null);
               }
            }
            else
            {
               this.FPuTongAwakenDateCELL.SetValueById(this.FCurrentRole.AwakenCommonSkillId);
               this.FMC_PuTongSlot.SetDate(this.FPuTongAwakenDateCELL);
               this.FTF_PuTongSkillDec.text = this.FPuTongAwakenDateCELL.AwakenSkillDate.Description;
               this.FTextFormat.color = CONST_COMMON.QUALITYCOLOR_INDEX[this.FPuTongAwakenDateCELL.AwakenSkillDate.Quality];
               this.FTF_PuTongSkillName.text = this.FPuTongAwakenDateCELL.AwakenSkillDate.Name;
               this.FTF_PuTongSkillName.setTextFormat(this.FTextFormat);
               this.FTF_PuTongAddGold.text = STRING_AWAKEN.Str778;
            }
            if(this.FCurrentRole.AwakenSpecialSkillId == 0)
            {
               this.FMC_TeShuSlot.SetDate(null);
               this.FTF_TeShuSkillDec.text = "";
               this.FTF_TeShuSkillName.text = "";
               this.FTF_TeShuAddGold.text = STRING_AWAKEN.Str887;
               if(this.FBackOut != null)
               {
                  this.FBackOut(null);
               }
            }
            else
            {
               this.FTeShuAwakenDateCELL.SetValueById(this.FCurrentRole.AwakenSpecialSkillId);
               this.FMC_TeShuSlot.SetDate(this.FTeShuAwakenDateCELL);
               this.FTF_TeShuSkillDec.text = this.FTeShuAwakenDateCELL.AwakenSkillDate.Description;
               this.FTF_TeShuSkillName.text = this.FTeShuAwakenDateCELL.AwakenSkillDate.Name;
               this.FTextFormat.color = CONST_COMMON.QUALITYCOLOR_INDEX[this.FTeShuAwakenDateCELL.AwakenSkillDate.Quality];
               this.FTF_TeShuSkillName.setTextFormat(this.FTextFormat);
               this.FTF_TeShuAddGold.text = STRING_AWAKEN.Str888;
            }
         }
         else
         {
            this.FMC_PuTongSlot.SetDate(null);
            this.FMC_TeShuSlot.SetDate(null);
         }
      }
      
      public function UpdateImage() : void
      {
         var _loc1_:int = 0;
         if(!this.visible)
         {
            return;
         }
         if(this.CurDateVec == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < TWOFIVE)
         {
            this.SlotVec[_loc1_].UpdateImage();
            _loc1_++;
         }
         this.FMC_TeShuSlot.UpdateImage();
         this.FMC_PuTongSlot.UpdateImage();
      }
      
      public function SetIdForHero() : void
      {
         if(this.CurType == 4)
         {
            if(this.CurAwakenDateCELL.AwakenSkillDate.Type == 3)
            {
               this.FCurrentRole.AwakenSpecialSkillId = 0;
            }
            else
            {
               this.FCurrentRole.AwakenCommonSkillId = 0;
            }
         }
         else if(this.CurAwakenDateCELL.AwakenSkillDate.Type == 3)
         {
            this.FCurrentRole.AwakenSpecialSkillId = this.CurAwakenDateCELL.AwakenSkillDate.Identifier;
         }
         else
         {
            this.FCurrentRole.AwakenCommonSkillId = this.CurAwakenDateCELL.AwakenSkillDate.Identifier;
         }
      }
      
      protected function FBackClickB(param1:AwakenDateCELL) : void
      {
         this.CurAwakenDateCELL = param1;
         this.CurType = 3;
         if(this.FBackClick != null)
         {
            this.FBackClick(param1,this.FCurrentRole.Identifier,0);
         }
      }
      
      protected function FBackClickC(param1:AwakenDateCELL) : void
      {
         this.CurAwakenDateCELL = param1;
         this.CurType = 4;
         if(this.FBackClick != null)
         {
            this.FBackClick(param1,this.FCurrentRole.Identifier,1);
         }
      }
      
      protected function HandleClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FThisPanel["btn_Close"]:
               this.visible = false;
         }
      }
      
      public function set BackClick(param1:Function) : void
      {
         this.FBackClick = param1;
      }
      
      public function set BackOver(param1:Function) : void
      {
         this.FBackOver = param1;
      }
      
      public function set BackOut(param1:Function) : void
      {
         this.FBackOut = param1;
      }
      
      public function set BackMove(param1:Function) : void
      {
         this.FBackMove = param1;
      }
   }
}

