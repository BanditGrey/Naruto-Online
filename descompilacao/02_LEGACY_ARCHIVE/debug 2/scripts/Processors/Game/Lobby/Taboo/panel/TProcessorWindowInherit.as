package Processors.Game.Lobby.Taboo.panel
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Taboo.Cell.THeroLittleBar;
   import Processors.Game.Lobby.Taboo.Data.TabooDataCell;
   import Rendering.Overlayers.Taboo.TOverTabooStringTip;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_TABOO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TABOO;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowInherit extends TProcessorLobbyWindow
   {
      
      public static const Six:int = 5;
      
      protected var MainPanel:Sprite = null;
      
      protected var FBtn_Close:SimpleButton = null;
      
      protected var FIsInilization:Boolean;
      
      protected var FMC_List_Left:MovieClip = null;
      
      protected var FMC_List_Right:MovieClip = null;
      
      protected var FScrollBarLeft:TScrollBar = null;
      
      protected var FScrollBarRight:TScrollBar = null;
      
      protected var FLeftList:MovieClip = null;
      
      protected var FRightList:MovieClip = null;
      
      protected var FTF_Name:TextField = null;
      
      protected var FIsGold:int;
      
      protected var heros:THeros = null;
      
      protected var CurLeftHero:THero = null;
      
      protected var CurRightHero:THero = null;
      
      protected var FLeftMC_Btn:MovieClip = null;
      
      protected var FRightMC_Btn:MovieClip = null;
      
      protected var FTExpDecTip:TOverTabooStringTip = null;
      
      protected var FBtn_Inherit:SimpleButton = null;
      
      protected var LeftText1:Vector.<TextField> = null;
      
      protected var RightText1:Vector.<TextField> = null;
      
      protected var RightText2:Vector.<TextField> = null;
      
      protected var FTF_pre_Inherit0:TextField = null;
      
      protected var FTF_pre_Inherit1:TextField = null;
      
      protected var FBMLeft:Bitmap;
      
      protected var FBMRight:Bitmap;
      
      protected var HeadIDLeft:uint;
      
      protected var HeadIDRight:uint;
      
      protected var FBackFun:Function;
      
      protected var IsCanInherit:Boolean;
      
      protected var FBInheritFun:Function = null;
      
      protected var FCurCostGold:uint;
      
      public function TProcessorWindowInherit(param1:TUIComponent)
      {
         super(param1);
         this.LeftText1 = new Vector.<TextField>();
         this.RightText1 = new Vector.<TextField>();
         this.RightText2 = new Vector.<TextField>();
         this.FBMLeft = new Bitmap();
         this.FBMRight = new Bitmap();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TABOO.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TABOO.MC_ExpInherit) as Sprite;
         addChild(this.MainPanel);
         this.MainPanel.x = (FUICore.StageWidth - this.MainPanel.width) / 2;
         this.MainPanel.y = (FUICore.StageHeight - this.MainPanel.height) / 2;
         _loc1_ = 0;
         while(_loc1_ < Six)
         {
            this.LeftText1.push(this.MainPanel["MC_Explain0"]["TF_Value_" + _loc1_]);
            this.RightText1.push(this.MainPanel["MC_Explain1"]["TF_Value_" + _loc1_]);
            this.RightText2.push(this.MainPanel["MC_Explain1"]["TF_extra_Value_" + _loc1_]);
            _loc1_++;
         }
         this.FBtn_Close = this.MainPanel["Btn_Close"];
         this.FBtn_Inherit = this.MainPanel["Btn_Inherit"];
         this.FMC_List_Left = this.MainPanel["MC_List_Left"];
         this.FMC_List_Right = this.MainPanel["MC_List_Right"];
         this.FLeftMC_Btn = this.FMC_List_Left["mc_bar"]["MC_Btn"];
         this.FTF_Name = this.MainPanel["TF_Name"];
         this.FRightMC_Btn = this.FMC_List_Right["mc_bar"]["MC_Btn"];
         this.FTF_pre_Inherit0 = this.MainPanel["TF_pre_Inherit0"];
         this.FTF_pre_Inherit1 = this.MainPanel["TF_pre_Inherit1"];
         this.FLeftMC_Btn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         TGameUtil.setButtonMode(this.FLeftMC_Btn,true);
         this.FRightMC_Btn.addEventListener(MouseEvent.CLICK,this.BtnClick);
         this.FBtn_Inherit.addEventListener(MouseEvent.CLICK,this.BtnClick);
         TGameUtil.setButtonMode(this.FRightMC_Btn,true);
         MovieClip(this.MainPanel["MC_HeadFirst"]["MC_Head"]).addChild(this.FBMLeft);
         MovieClip(this.MainPanel["MC_HeadSecond"]["MC_Head"]).addChild(this.FBMRight);
         this.FLeftList = this.FMC_List_Left["mc_list"];
         this.FRightList = this.FMC_List_Right["mc_list"];
         this.FLeftList.visible = false;
         this.FRightList.visible = false;
         this.FScrollBarLeft = new TScrollBar(this.FLeftList,75,true,0);
         this.FScrollBarRight = new TScrollBar(this.FRightList,75,true,0);
         this.FScrollBarLeft.Clear();
         this.FScrollBarRight.Clear();
         this.FTExpDecTip = new TOverTabooStringTip(this.Parent);
         this.FTExpDecTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTExpDecTip);
         this.FIsInilization = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function BtnClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FLeftMC_Btn:
               this.FLeftList.visible = this.FLeftList.visible ? false : true;
               break;
            case this.FRightMC_Btn:
               this.FRightList.visible = this.FRightList.visible ? false : true;
               break;
            case this.FBtn_Inherit:
               if(Boolean(this.FBInheritFun != null && this.CurRightHero) && Boolean(this.CurLeftHero) && !this.IsCanInherit)
               {
                  this.IsCanInherit = true;
                  this.FBInheritFun(this.CurLeftHero,this.CurRightHero,this.FCurCostGold);
               }
         }
      }
      
      public function set CanInherit(param1:Boolean) : void
      {
         this.IsCanInherit = param1;
      }
      
      public function set BInheritFun(param1:Function) : void
      {
         this.FBInheritFun = param1;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:Vector.<uint> = null;
         super.ResourcesPerform_UILocations();
         var _loc2_:TConfigValue = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TABOO_COSTGOLDE) as TConfigValue;
         _loc1_ = _loc2_.Value as Vector.<uint>;
         SLogicsCore.TBooData.InheritCostGold = _loc1_;
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.CloseClick);
      }
      
      public function OpenThisPanel() : void
      {
         this.CurRightHero = null;
         this.CurLeftHero = null;
         this.UpdateView();
      }
      
      public function UpdateListBar() : void
      {
         this.RealRight();
         this.RealLeft();
      }
      
      protected function PanelClickRight(param1:THero) : void
      {
         this.CurRightHero = param1;
         if(param1.IsSkillInherited)
         {
            return;
         }
         if(this.CurLeftHero)
         {
            if(this.CurRightHero.Identifier == this.CurLeftHero.Identifier)
            {
               return;
            }
         }
         this.FRightList.visible = false;
         this.HeadIDRight = this.CurRightHero.SmallID;
         TextField(this.FMC_List_Right["mc_bar"]["TF_Name"]).text = param1.Name;
         TextField(this.FMC_List_Right["mc_bar"]["TF_Name"]).textColor = CONST_COMMON.QUALITYCOLOR_INDEX[param1.Quality];
         this.FTF_pre_Inherit1.text = STRING_COMMON.TYPE_PROFESSIONS[this.CurRightHero.Profession];
         this.UpdateView();
      }
      
      public function setNull() : void
      {
         this.CurRightHero = null;
         this.CurLeftHero = null;
      }
      
      protected function PanelClickLeft(param1:THero) : void
      {
         this.CurLeftHero = param1;
         this.HeadIDLeft = 0;
         if(param1.IsSkillInherit)
         {
            return;
         }
         if(this.CurRightHero)
         {
            if(this.CurLeftHero.Identifier == this.CurRightHero.Identifier)
            {
               return;
            }
         }
         this.FLeftList.visible = false;
         this.HeadIDLeft = this.CurLeftHero.SmallID;
         TextField(this.FMC_List_Left["mc_bar"]["TF_Name"]).text = param1.Name;
         TextField(this.FMC_List_Left["mc_bar"]["TF_Name"]).textColor = CONST_COMMON.QUALITYCOLOR_INDEX[param1.Quality];
         this.FTF_pre_Inherit0.text = STRING_COMMON.TYPE_PROFESSIONS[this.CurLeftHero.Profession];
         this.UpdateView();
      }
      
      protected function GetAllValueByNum(param1:THero, param2:int) : uint
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.TabooMounted.length)
         {
            if(param1.TabooMounted[_loc3_].ConfigureAddition.AddProperty.length > 1)
            {
               if(param1.TabooMounted[_loc3_].ConfigureAddition.AddProperty[0][0] == param2 || param1.TabooMounted[_loc3_].ConfigureAddition.AddProperty[1][0] == param2)
               {
                  _loc4_ += param1.TabooMounted[_loc3_].ConfigureAddition.AddProperty[0][1] * param1.TabooMounted[_loc3_].SkillCount;
               }
            }
            else if(param1.TabooMounted[_loc3_].ConfigureAddition.AddProperty[0][0] == param2)
            {
               _loc4_ += param1.TabooMounted[_loc3_].ConfigureAddition.AddProperty[0][1] * param1.TabooMounted[_loc3_].SkillCount;
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      protected function GetTabooDataCellByNum(param1:THero, param2:THero, param3:int) : uint
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:TabooDataCell = null;
         var _loc10_:Vector.<TabooDataCell> = new Vector.<TabooDataCell>();
         _loc10_.length = 0;
         _loc4_ = 0;
         while(_loc4_ < param2.TabooMounted.length)
         {
            if(param2.TabooMounted[_loc4_].ConfigureAddition.AddProperty.length > 1)
            {
               if(param2.TabooMounted[_loc4_].ConfigureAddition.AddProperty[0][0] == param3 || param2.TabooMounted[_loc4_].ConfigureAddition.AddProperty[1][0] == param3)
               {
                  _loc10_.push(param2.TabooMounted[_loc4_]);
               }
            }
            else if(param2.TabooMounted[_loc4_].ConfigureAddition.AddProperty[0][0] == param3)
            {
               _loc10_.push(param2.TabooMounted[_loc4_]);
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc10_.length)
         {
            _loc8_ = _loc10_[_loc4_].SkillCount * _loc10_[_loc4_].ConfigureAddition.AddProperty[0][1];
            _loc5_ = 0;
            while(_loc5_ < param1.TabooMounted.length)
            {
               if(_loc10_[_loc4_].ConfigureConfig.Identifier == param1.TabooMounted[_loc5_].ConfigureConfig.Identifier)
               {
                  if(_loc10_[_loc4_].SkillCount > param1.TabooMounted[_loc5_].SkillCount)
                  {
                     _loc7_ += (_loc10_[_loc4_].SkillCount - param1.TabooMounted[_loc5_].SkillCount) * _loc10_[_loc4_].ConfigureAddition.AddProperty[0][1];
                     this.FCurCostGold += (_loc10_[_loc4_].SkillCount - param1.TabooMounted[_loc5_].SkillCount) * SLogicsCore.TBooData.InheritCostGold[_loc10_[_loc4_].ConfigureConfig.Quality - 1];
                  }
                  _loc8_ = 0;
                  break;
               }
               _loc5_++;
            }
            if(_loc8_ != 0)
            {
               this.FCurCostGold += _loc10_[_loc4_].SkillCount * SLogicsCore.TBooData.InheritCostGold[_loc10_[_loc4_].ConfigureConfig.Quality - 1];
            }
            _loc6_ += _loc8_;
            _loc4_++;
         }
         return _loc6_ + _loc7_;
      }
      
      public function UpdateS_C() : void
      {
         this.CurLeftHero = null;
         this.CurRightHero = null;
         this.UpdateView();
         this.IsCanInherit = false;
      }
      
      public function UpdateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         if(!this.FIsInilization)
         {
            return;
         }
         var _loc3_:Array = null;
         var _loc4_:TabooDataCell = null;
         var _loc5_:TabooDataCell = null;
         if(!this.CurLeftHero)
         {
            TextField(this.FMC_List_Left["mc_bar"]["TF_Name"]).text = "";
            this.FTF_pre_Inherit0.text = "";
            this.FLeftList.visible = false;
            this.HeadIDLeft = 0;
            if(this.FBMLeft)
            {
               this.FBMLeft.visible = false;
            }
            _loc1_ = 0;
            while(_loc1_ < Six)
            {
               this.LeftText1[_loc1_].text = "0";
               _loc1_++;
            }
         }
         else
         {
            if(this.FBMLeft)
            {
               this.FBMLeft.visible = true;
            }
            _loc1_ = 0;
            while(_loc1_ < Six)
            {
               this.LeftText1[_loc1_].text = this.GetAllValueByNum(this.CurLeftHero,CONST_COMMON.BASEATTRIBUTENAMESCOPY[_loc1_]).toString();
               _loc1_++;
            }
         }
         if(!this.CurRightHero)
         {
            TextField(this.FMC_List_Right["mc_bar"]["TF_Name"]).text = "";
            this.FTF_pre_Inherit1.text = "";
            this.FRightList.visible = false;
            this.HeadIDRight = 0;
            if(this.FBMRight)
            {
               this.FBMRight.visible = false;
            }
            _loc1_ = 0;
            while(_loc1_ < Six)
            {
               this.RightText1[_loc1_].text = "0";
               _loc1_++;
            }
         }
         else
         {
            if(this.FBMRight)
            {
               this.FBMRight.visible = true;
            }
            _loc1_ = 0;
            while(_loc1_ < Six)
            {
               this.RightText1[_loc1_].text = this.GetAllValueByNum(this.CurRightHero,CONST_COMMON.BASEATTRIBUTENAMESCOPY[_loc1_]).toString();
               _loc1_++;
            }
         }
         this.FCurCostGold = 0;
         if(Boolean(this.CurRightHero) && Boolean(this.CurLeftHero))
         {
            this.FBtn_Inherit.filters = [];
            this.FBtn_Inherit.mouseEnabled = true;
            _loc1_ = 0;
            while(_loc1_ < Six)
            {
               this.RightText2[_loc1_].text = this.GetTabooDataCellByNum(this.CurRightHero,this.CurLeftHero,CONST_COMMON.BASEATTRIBUTENAMESCOPY[_loc1_]).toString();
               _loc1_++;
            }
         }
         else
         {
            this.FBtn_Inherit.filters = [TGameUtil.GaryColorFilters];
            this.FBtn_Inherit.mouseEnabled = false;
            _loc1_ = 0;
            while(_loc1_ < Six)
            {
               this.RightText2[_loc1_].text = "0";
               _loc1_++;
            }
         }
         this.SetValueText();
         this.UpdateListBar();
      }
      
      protected function SetValueText() : void
      {
         if(this.FCurCostGold == 0)
         {
            this.FTF_Name.text = "";
         }
         else
         {
            this.FTF_Name.text = TUtilityString.Format(STRING_TABOO.Str17,this.FCurCostGold);
         }
      }
      
      protected function GetBoolean(param1:TabooDataCell) : TabooDataCell
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         _loc2_ = 0;
         while(_loc2_ < Six)
         {
            _loc3_ = 0;
            while(_loc3_ < this.CurRightHero.TabooMounted.length)
            {
               if(param1.ConfigureAddition.Identifier == this.CurRightHero.TabooMounted[_loc3_].ConfigureAddition.Identifier)
               {
                  return this.CurRightHero.TabooMounted[_loc3_];
               }
               _loc3_++;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function MoMo(param1:THero) : void
      {
      }
      
      public function OvMo(param1:THero) : void
      {
      }
      
      protected function GetStr(param1:THero) : String
      {
         if(param1.IsSkillInherit && param1.IsSkillInherited)
         {
            return STRING_TABOO.Str4;
         }
         if(param1.IsSkillInherit)
         {
            return STRING_TABOO.Str21;
         }
         if(param1.IsSkillInherited)
         {
            return STRING_TABOO.Str22;
         }
         return STRING_TABOO.Str1;
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      protected function CloseClick(param1:MouseEvent) : void
      {
         this.visible = false;
         if(this.FBackFun != null)
         {
            this.FBackFun();
         }
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.FIsInilization || !this.visible)
         {
            return;
         }
         this.UpdateImage();
         super.LogicsPerform();
      }
      
      protected function UpdateImage() : void
      {
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FBMLeft,CONST_MODULES.MODULE_Taboo,this.HeadIDLeft);
         TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FBMRight,CONST_MODULES.MODULE_Taboo,this.HeadIDRight);
      }
      
      protected function RealRight() : void
      {
         var _loc2_:int = 0;
         this.heros = SLogicsCore.Character.Heros;
         this.FScrollBarRight.Clear();
         var _loc1_:THeroLittleBar = null;
         if(this.CurLeftHero != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this.heros.Count)
            {
               if(this.heros.GetHeroByIndex(_loc2_).Identifier != this.CurLeftHero.Identifier)
               {
                  _loc1_ = new THeroLittleBar();
                  _loc1_.SetData(this.heros.GetHeroByIndex(_loc2_));
                  _loc1_.ThisPanelClick = this.PanelClickRight;
                  _loc1_.ThisPanelMove = this.MoMo;
                  _loc1_.ThisPanelOut = this.OvMo;
                  this.FScrollBarRight.AddItem(_loc1_);
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < this.heros.Count)
            {
               _loc1_ = new THeroLittleBar();
               _loc1_.SetData(this.heros.GetHeroByIndex(_loc2_));
               _loc1_.ThisPanelClick = this.PanelClickRight;
               _loc1_.ThisPanelMove = this.MoMo;
               _loc1_.ThisPanelOut = this.OvMo;
               this.FScrollBarRight.AddItem(_loc1_);
               _loc2_++;
            }
         }
         this.FScrollBarRight.ScrollToUp();
      }
      
      protected function RealLeft() : void
      {
         var _loc2_:int = 0;
         this.heros = SLogicsCore.Character.Heros;
         this.FScrollBarLeft.Clear();
         var _loc1_:THeroLittleBar = null;
         if(this.CurRightHero != null)
         {
            _loc2_ = 0;
            while(_loc2_ < this.heros.Count)
            {
               if(this.heros.GetHeroByIndex(_loc2_).Identifier != this.CurRightHero.Identifier && this.heros.GetHeroByIndex(_loc2_).TabooMounted.length > 0)
               {
                  _loc1_ = new THeroLittleBar();
                  _loc1_.SetData(this.heros.GetHeroByIndex(_loc2_));
                  _loc1_.ThisPanelClick = this.PanelClickLeft;
                  _loc1_.ThisPanelMove = this.MoMo;
                  _loc1_.ThisPanelOut = this.OvMo;
                  this.FScrollBarLeft.AddItem(_loc1_);
               }
               _loc2_++;
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < this.heros.Count)
            {
               if(this.heros.GetHeroByIndex(_loc2_).TabooMounted.length > 0)
               {
                  _loc1_ = new THeroLittleBar();
                  _loc1_.SetData(this.heros.GetHeroByIndex(_loc2_));
                  _loc1_.ThisPanelClick = this.PanelClickLeft;
                  _loc1_.ThisPanelMove = this.MoMo;
                  _loc1_.ThisPanelOut = this.OvMo;
                  this.FScrollBarLeft.AddItem(_loc1_);
               }
               _loc2_++;
            }
         }
         this.FScrollBarLeft.ScrollToUp();
      }
   }
}

